extends KinematicBody2D

export(float) var speed : float = 30.0
export(float) var upper_limit : float = 70.0
export(float) var lower_limit : float = 530.0

var direction : Vector2


func _physics_process(delta: float) -> void:

	if Global.ball_position.y > upper_limit and Global.ball_position.y < lower_limit:
		global_position.y = Global.ball_position.y
