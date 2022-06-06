extends Node

var collisionSFX = load("res://assets/Sound/SN_Collide.wav")
var deathSFX = load("res://assets/Sound/SN_Death.wav")
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func play_collisionSFX():
	$Music.stream = collisionSFX
	$Music.play()

func play_deathsfx():
	$Music.stream = deathSFX
	$Music.play()
