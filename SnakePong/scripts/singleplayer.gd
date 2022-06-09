extends Node2D

var survival_time = 0.0

func _process(delta: float):
	survival_time += delta

func _on_Snake_game_over():
	Global.p0lost = true
	Global.death_position = $Snake.position + $Snake/Head.position
	
	get_tree().change_scene("res://scenes/TitleScreen.tscn")
