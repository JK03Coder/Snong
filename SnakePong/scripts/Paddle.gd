extends KinematicBody2D

export(float) var speed : float = 30.0

var direction : Vector2


func _physics_process(delta: float) -> void:

	global_position.y = Global.ball_position.y
