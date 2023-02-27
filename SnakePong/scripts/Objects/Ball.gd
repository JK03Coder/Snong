extends RigidBody2D

export(float) var speed = 200.0
export(float) var deltaSpeed = 10.0
export(float) var changeTime = 3.0

func _ready():
	$Timer.start(changeTime)
	#var angle = float(randi()%1 - 1)*(rand_range(20.0, 40.0))
	#linear_velocity = Vector2(cos(angle), sin(angle)) * speed

func _process(_delta: float) -> void:
	# Sets a global ball position.
	Global.ball_position = global_position
	# Rotates sprite based on angle of velocity.
	$AnimatedSprite.rotation_degrees = linear_velocity.angle() * 180 / PI
	# Fixes speed if it gets messed up in bouncing.
	if (linear_velocity.length() > speed + 5) || (linear_velocity.length() < speed - 5):
		linear_velocity = linear_velocity.normalized() * speed

func _on_Timer_timeout():
	speed += deltaSpeed
	$Timer.start(changeTime)
