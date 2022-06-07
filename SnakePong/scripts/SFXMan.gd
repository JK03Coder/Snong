extends Node

var collisionSFX = load("res://assets/Sound/SN_Collide.wav")
var deathSFX = load("res://assets/Sound/SN_Death.wav")
var coinslotSFX = load("res://assets/Sound/coin_slotted.mp3")

onready var coinslotSFXtimer := $CoinSlotSFXTimer
onready var music := $Music

func play_collisionSFX():
	music.stream = collisionSFX
	music.volume_db = -11.0
	music.play()

func play_deathsfx():
	music.stream = deathSFX
	music.volume_db = 8.0
	music.play()
