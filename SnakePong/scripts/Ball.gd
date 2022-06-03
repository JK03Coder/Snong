extends RigidBody2D

export(float) var speed = 200

func _process(delta: float) -> void:
	# Sets a global ball position.
	Global.ball_position = global_position
	
func _physics_process(delta: float):
	# Sets velocity to a baseline speed
	if linear_velocity.length() > speed:
		linear_velocity = linear_velocity.normalized() * speed
	# Rotates sprite based on angle of velocity.
	$AnimatedSprite.rotation_degrees = linear_velocity.angle()
