extends KinematicBody2D

export(PackedScene) var body
export(int, 0, 50) var body_segments = 20

const SPEED = 100

var input_dir := Vector2.RIGHT
var move_dir := Vector2.RIGHT
var turn_rate = 0.1
var segment_delay : float = 0.5
var current_segments : int = 0
var turn_markers : Array = []

onready var lag_timer := Timer.new()
onready var body_spawn_pos : Vector2 = global_position

func _ready():
	assert(body != null, "add a scene to the export var body")
	lag_timer.connect("timeout", self, "lag_timeout")
	lag_timer.wait_time = segment_delay
	add_child(lag_timer)
	lag_timer.start()


func lag_timeout():
	if current_segments <= body_segments:
		var new_body = body.instance()
		new_body.global_position = body_spawn_pos
		new_body.segment_id = current_segments
		add_child(new_body)
		lag_timer.start()
		current_segments += 1


func update_turn(direction: Vector2):
	input_dir = direction
	turn_markers.append(global_position)


func _physics_process(_delta: float) -> void:
	# if you press multiple keys at the same time
	# it will prioritze the last checked keys
	if Input.is_action_just_pressed("move_right") and move_dir.dot(Vector2.RIGHT) >= 0:
		update_turn(Vector2.RIGHT)
	if Input.is_action_just_pressed("move_left") and move_dir.dot(Vector2.LEFT) >= 0:
		update_turn(Vector2.LEFT)
	if Input.is_action_just_pressed("move_up") and move_dir.dot(Vector2.UP) >= 0:
		update_turn(Vector2.UP)
	if Input.is_action_just_pressed("move_down") and move_dir.dot(Vector2.DOWN) >= 0:
		update_turn(Vector2.DOWN)
	move_dir.x = move_toward(move_dir.x, input_dir.x, turn_rate)
	move_dir.y = move_toward(move_dir.y, input_dir.y, turn_rate)
	move_and_slide(move_dir * SPEED)
