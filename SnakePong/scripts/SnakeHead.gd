extends KinematicBody2D

export(PackedScene) var body

const SPEED = 100

var input_dir := Vector2.RIGHT
var move_dir := Vector2.RIGHT
var turn_rate = 0.1

onready var lag_pos := Vector2.ZERO
onready var lag_timer := Timer.new()

func _ready():
	assert(body != null, "add a scene to the export var body")
	lag_timer.wait_time = 0.5
	lag_timer.connect("timeout", self, "lag_timeout")
	add_child(lag_timer)
	lag_timer.start()


func lag_timeout():
	var new_body = body.instance()
	new_body.global_position = lag_pos
	lag_pos = global_position
	add_child(new_body)
	lag_timer.start()


func _physics_process(delta: float) -> void:
	# if you press multiple keys at the same time
	# it will prioritze the last checked keys
	if Input.is_action_just_pressed("move_right") and move_dir.dot(Vector2.RIGHT) >= 0:
		input_dir = Vector2.RIGHT
	if Input.is_action_just_pressed("move_left") and move_dir.dot(Vector2.LEFT) >= 0:
		input_dir = Vector2.LEFT
	if Input.is_action_just_pressed("move_up") and move_dir.dot(Vector2.UP) >= 0:
		input_dir = Vector2.UP
	if Input.is_action_just_pressed("move_down") and move_dir.dot(Vector2.DOWN) >= 0:
		input_dir = Vector2.DOWN
	move_dir.x = move_toward(move_dir.x, input_dir.x, turn_rate)
	move_dir.y = move_toward(move_dir.y, input_dir.y, turn_rate)
	move_and_slide(move_dir * SPEED)
