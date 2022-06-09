extends Node

var collisionSFX = load("res://assets/Sound/SN_Collide.wav")
var deathSFX = load("res://assets/Sound/SN_Death.wav")

var clickSFX = load("res://assets/Sound/192270__lebaston100__click.wav")
var growthSFX = load("res://assets/Sound/235754__elliotlp__crumple-dry-leaf-2.mp3")

onready var firstFX := $FirstFX
onready var secondFX := $SecondFX

func play_collisionSFX():
	firstFX.stream = collisionSFX
	firstFX.volume_db = -11.0
	firstFX.play()

func play_deathsfx():
	firstFX.stream = deathSFX
	firstFX.volume_db = 5.0
	firstFX.play()

func play_clicksfx():
	secondFX.stream = clickSFX
	secondFX.volume_db = -10.0
	secondFX.play()

func play_growthsfx():
	secondFX.stream = growthSFX
	secondFX.volume_db = 0.0
	secondFX.play()
