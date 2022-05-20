extends KinematicBody2D

const SPEED = 100
var direction : Vector2
onready var parent := get_parent()


func _ready():
    set_as_toplevel(true)


func _physics_process(delta):
    direction = global_position.direction_to(parent.global_position).normalized()
    move_and_slide(direction * SPEED)