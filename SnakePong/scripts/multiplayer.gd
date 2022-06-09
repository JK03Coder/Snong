extends Node2D

export(int) var init_speed : int = 200


var survival_time = 0.0

func _process(delta):
	survival_time += delta
	

func _on_Snake1_game_over():
	Global.p1lost = true
	Global.death_position = $Snake1.position + $Snake1/Head.position
	Global.p2_time[0] = survival_time
	get_tree().change_scene("res://scenes/TitleScreen.tscn")

func _on_Snake2_game_over():
	Global.p2lost = true
	Global.death_position = $Snake2.position + $Snake2/Head.position
	Global.p1_time[0] = survival_time
	get_tree().change_scene("res://scenes/TitleScreen.tscn")

