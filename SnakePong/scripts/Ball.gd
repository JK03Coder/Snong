extends RigidBody2D

export(float) var speed = 200.0
export(float) var deltaSpeed = 10.0
export(float) var changeTime = 3.0

func _ready():
	$Timer.start(changeTime)


func _process(delta: float) -> void:
	# Sets a global ball position.
	Global.ball_position = global_position
	# Rotates sprite based on angle of velocity.
	$AnimatedSprite.rotation_degrees = linear_velocity.angle() * 180 / PI
	# Fixes speed if it gets messed up in bouncing.
	if linear_velocity.length() > speed:
		linear_velocity = linear_velocity.normalized() * speed

func _on_Timer_timeout():
	speed += deltaSpeed
	$Timer.start(changeTime)
