extends Node

var collisionSFX = load("res://assets/Sound/SN_Collide.wav")
var deathSFX = load("res://assets/Sound/SN_Death.wav")

func play_collisionSFX():
	$Music.stream = collisionSFX
	$Music.volume_db = -10.0
	$Music.play()

func play_deathsfx():
	$Music.stream = deathSFX
	$Music.volume_db = 5.0
	$Music.play()
