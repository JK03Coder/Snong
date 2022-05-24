extends RigidBody2D

export(float) var force : float = 10

func _integrate_forces(state: Physics2DDirectBodyState) -> void:
	if Global.ball_position.y > global_position.y:
		apply_central_impulse(Vector2.DOWN * force)
	else:
		apply_central_impulse(Vector2.UP * force)
