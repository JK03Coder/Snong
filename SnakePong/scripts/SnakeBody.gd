extends KinematicBody2D

var direction : Vector2 = Vector2.RIGHT
var move_dir : Vector2 = Vector2.RIGHT
var segment_id : int

onready var parent := get_parent()
onready var turn_rate : float = parent.turn_rate
onready var speed = parent.speed

func _init():
	set_as_toplevel(true)


func _physics_process(delta):
	if len(parent.turn_markers) > 0:
		direction = global_position.direction_to(parent.turn_markers[segment_id]).normalized()

	move_dir.x = move_toward(move_dir.x, direction.x, turn_rate)
	move_dir.y = move_toward(move_dir.y, direction.y, turn_rate)
	move_and_slide(move_dir * speed)
