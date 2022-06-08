extends Node2D

func _on_Snake1_game_over():
	Global.p2won = true
	get_tree().change_scene("res://scenes/TitleScreen.tscn")

func _on_Snake2_game_over():
	Global.p1won = true
	get_tree().change_scene("res://scenes/TitleScreen.tscn")
