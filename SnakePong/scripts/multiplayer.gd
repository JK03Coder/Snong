extends Node2D

func _on_Snake1_game_over():
	get_tree().change_scene("res://scenes/TitleScreen.tscn")

func _on_Snake2_game_over():
	get_tree().change_scene("res://scenes/TitleScreen.tscn")
