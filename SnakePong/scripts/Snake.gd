extends Node2D

export(PackedScene) var tail
export(int) var speed = 100
export(int, 0, 50) var tail_segments = 20
export(int) var segment_gap : int = 16

var turn_rate : float = 0.1
var input_dir : Vector2 = Vector2.RIGHT
var changed_dir : bool = false

onready var head := $Head


func _ready():
	assert(tail != null, "add a scene to the export var tail")
	# add the starting tail segments
	for i in tail_segments:
		add_tail()


func _physics_process(delta: float) -> void:
	# if a movement key is pressed once
	if Input.is_action_just_pressed("move_down") or Input.is_action_just_pressed("move_up") or Input.is_action_just_pressed("move_right") or Input.is_action_just_pressed("move_left"):
		# if you're moving along the x axis
		if abs(input_dir.dot(Vector2.RIGHT)) == 1.0:
			var strength = Vector2(0.0, Input.get_action_strength("move_down") - Input.get_action_strength("move_up"))
			# if you didn't press both at the same time change direction
			if strength != Vector2.ZERO:
				input_dir = strength
				changed_dir = true
		# if you're moving along the y axis
		else:
			var strength = Vector2(Input.get_action_strength("move_right") - Input.get_action_strength("move_left"), 0.0)
			# if you didn't press both at the same time change direction
			if strength != Vector2.ZERO:
				input_dir = strength
				changed_dir = true

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


func hit_self() -> void:
	get_tree().reload_current_scene()
