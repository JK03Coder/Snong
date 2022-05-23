extends Node2D

var speed = 900
var angular_speed = PI


func _process(delta):
	#rotation += angular_speed * delta
	#var velocity = Vector2.UP.rotated(rotation) * speed
	#position += velocity * delta
	
	position.y += delta * 300 #Testing y-movement being linked globally
	Global.ballPosY = position.y
