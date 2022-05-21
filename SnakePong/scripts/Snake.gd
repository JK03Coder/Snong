extends Node2D

export(PackedScene) var tail
export(int, 0, 50) var tail_segments = 20
export(int) var speed = 100

var current_segments : int = 0
var turn_rate : float = 0.1
var segment_delay : float = 0.25
var input_dir : Vector2 = Vector2.RIGHT
var move_dir : Vector2 = Vector2.RIGHT

onready var head := $Head
onready var spawn_timer := Timer.new()


func _ready():
	assert(tail != null, "add a scene to the export var tail")
	spawn_timer.connect("timeout", self, "spawn_timeout")
	spawn_timer.wait_time = segment_delay
	add_child(spawn_timer)
	spawn_timer.start()


func spawn_timeout():
	if current_segments <= tail_segments:
		var new_tail = tail.instance()
		add_child(new_tail)
		spawn_timer.start()
		current_segments += 1


func _physics_process(delta: float) -> void:
	# if a movement key is pressed once
	if Input.is_action_just_pressed("move_down") or Input.is_action_just_pressed("move_up") or Input.is_action_just_pressed("move_right") or Input.is_action_just_pressed("move_left"):
		# if you're moving along the x axis
		if abs(input_dir.dot(Vector2.RIGHT)) == 1.0:
			var strength = Vector2(0.0, Input.get_action_strength("move_down") - Input.get_action_strength("move_up"))
			# if you didn't press both at the same time change direction
			if strength != Vector2.ZERO:
				input_dir = strength
		# if you're moving along the y axis
		else:
			var strength = Vector2(Input.get_action_strength("move_right") - Input.get_action_strength("move_left"), 0.0)
			# if you didn't press both at the same time change direction
			if strength != Vector2.ZERO:
				input_dir = strength

	move_dir.x = move_toward(move_dir.x, input_dir.x, turn_rate)
	move_dir.y = move_toward(move_dir.y, input_dir.y, turn_rate)
	head.position += move_dir * delta * speed
