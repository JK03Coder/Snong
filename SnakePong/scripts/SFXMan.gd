extends Node

var collisionSFX = load("res://assets/Sound/SN_Collide.wav")
var deathSFX = load("res://assets/Sound/SN_Death.wav")
var coinslotSFX = load("res://assets/Sound/coin_slotted.mp3")

func play_collisionSFX():
	$Music.stream = collisionSFX
	$Music.volume_db = -11.0
	$Music.play()

func play_deathsfx():
	$Music.stream = deathSFX
	$Music.volume_db = 8.0
	$Music.play()

func play_coinsfx():
	$Music.stream = coinslotSFX
	$Music.volume_db = 5.0
	$Music.play()
