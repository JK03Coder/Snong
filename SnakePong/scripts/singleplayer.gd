extends Node2D

var time_survived = 0
onready var survival_timer = $SurvivalTimer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.





func _on_Snake_game_over():
		get_tree().change_scene("res://scenes/TitleScreen.tscn")
