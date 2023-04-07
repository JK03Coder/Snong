extends Node2D

export(String, FILE, "*.tscn,*.scn") var title
export(PackedScene) var tail
export(int) var speed = 200
export(int) var deltaSpeed = 5
export(int, 0, 50) var tail_segments = 20
export(int, 0, 50) var win_segments = 1
export(int) var segment_gap : int = 12
export(int) var player_index: int = 0

var turn_rate : float = 0.1
var input_dir : Vector2 = Vector2.DOWN
var changed_dir : bool = false
var moveset : Array
var input_strength : Vector2
var delayed_input : bool = false

signal game_over
signal won

onready var head := $Head
onready var turn_delay := $Head/TurnDelay
onready var hit_delay := $Head/HitDelay
onready var sprite := $Head/AnimatedSprite
onready var growth_timer := $Head/GrowthTimer

func _ready():
	tail_segments = get_parent().init_segments
	match player_index:
		0:
			moveset = ["move_up", "move_down", "move_left", "move_right"]
		1:
			moveset = ["p1_up", "p1_down", "p1_left", "p1_right"]
		2:
			moveset = ["p2_up", "p2_down", "p2_left", "p2_right"]

	assert(tail != null, "add a scene to the export var tail")
	if player_index == 1:
		Global.p2_segments = tail_segments
	elif player_index == 2:
		Global.p1_segments = tail_segments
	else:
		Global.p0_segments = tail_segments
	win_segments = Global.win_segments_multi
	sprite.play("default")
	
	head.connect("body_exited", self, "on_body_exited")
	# add the starting tail segments
	for i in tail_segments:
		add_tail()


func _process(delta: float) -> void:
	# Rotation based on direction of motion
	if input_dir == Vector2.LEFT:
		sprite.rotation_degrees = 90.0
	elif input_dir == Vector2.UP:
		sprite.rotation_degrees = 180.0
	elif input_dir == Vector2.RIGHT:
		sprite.rotation_degrees = 270.0
	else:
		sprite.rotation_degrees = 0.0


func _physics_process(delta: float) -> void:
	# if a movement key is pressed once
	if (Input.is_action_just_pressed(moveset[1]) or Input.is_action_just_pressed(moveset[0]) or Input.is_action_just_pressed(moveset[3]) or Input.is_action_just_pressed(moveset[2])):
		# When player turns in a timeframe after the turn delay
		if turn_delay.is_stopped():
			# if you're moving along the x axis
			if abs(input_dir.dot(Vector2.RIGHT)) == 1.0:
				input_strength = Vector2(0.0, Input.get_action_strength(moveset[1]) - Input.get_action_strength(moveset[0]))
				# if you didn't press both at the same time change direction
				if input_strength != Vector2.ZERO:
					input_dir = input_strength
					changed_dir = true
			# if you're moving along the y axis
			else:
				input_strength = Vector2(Input.get_action_strength(moveset[3]) - Input.get_action_strength(moveset[2]), 0.0)
				# if you didn't press both at the same time change direction
				if input_strength != Vector2.ZERO:
					input_dir = input_strength
					changed_dir = true
			turn_delay.start()
		# Otherwise when the player DOES turn within the turn delay
		else:
			if abs(input_dir.dot(Vector2.RIGHT)) == 1.0:
				input_strength = Vector2(0.0, Input.get_action_strength(moveset[1]) - Input.get_action_strength(moveset[0]))
			else:
				input_strength = Vector2(Input.get_action_strength(moveset[3]) - Input.get_action_strength(moveset[2]), 0.0)
			delayed_input = true

	if changed_dir:
		changed_dir = false
		# if direction has changed loop through all children except the Head
		for i in range(1, get_child_count()):
			get_child(i).add_turn(head.position, input_dir)
	head.position += input_dir * delta * speed


func add_tail() -> void:
	var tail_inst = tail.instance()
	var prev_tail = get_child(get_child_count() - 1)
	# if not head of snake
	if prev_tail.name != "Head":
		# set new tail direction to the tail in front of it it's direction
		tail_inst.cur_dir = prev_tail.cur_dir
		# add the turn direction and location history
		tail_inst.turns_loc.append_array(prev_tail.turns_loc)
		tail_inst.turns_dir.append_array(prev_tail.turns_dir)
		# set it's position to the tail in front of it
		# minus the opposite direction it's going by the segment gap size
		tail_inst.position = prev_tail.position + (-prev_tail.cur_dir * segment_gap)
	else:
		# if it is the first tail being added
		# do the same thing but without turns history
		tail_inst.cur_dir = input_dir
		tail_inst.position = head.position + (-input_dir * segment_gap)
		# set the first one to not detect collision
		tail_inst.monitorable = false
		tail_inst.monitoring = false
	# finally add the new tail instance as a child of Snake
	add_child(tail_inst)


func on_body_exited(body: Node) -> void:
	if body.name == "Ball":
		SfxMan.play_collisionSFX()
		remove_tail()
		growth_timer.start()


func remove_tail() -> void:
	if hit_delay.is_stopped():
		if player_index == 1:
			Global.p1_segments -= 1
		elif player_index == 2:
			Global.p2_segments -= 1
		else:
			Global.p0_segments -= 1
		if get_child_count() <= win_segments+2:
			emit_signal("won")
		get_child(get_child_count()-1).queue_free()
		speed += deltaSpeed
		hit_delay.start()


func death() -> void:
	SfxMan.play_deathsfx()
	emit_signal("game_over")
	queue_free()

# For when snake enters the void
func _on_Head_area_entered(area: Node):
	if area.is_in_group("death"):
		death()

# For delayed turns
func _on_TurnDelay_timeout():
	if delayed_input:
		if input_strength != Vector2.ZERO:
					input_dir = input_strength
					changed_dir = true
		delayed_input = false


#func _on_GrowthTimer_timeout():
#	if player_index == 1 and Global.p1_segments < tail_segments:
#		add_tail()
#		Global.p1_segments += 1
#		growth_timer.start()
#	elif player_index == 2 and Global.p2_segments < tail_segments:
#		add_tail()
#		Global.p2_segments += 1
#		growth_timer.start()
