extends Node2D

var survival_time = 0.0

func _process(delta: float):
	survival_time += delta

func _on_Snake_game_over():
	Global.p0lost = true
	Global.death_position = $Snake.position + $Snake/Head.position
	Global.p0_time[0] = survival_time
	if Global.p0_count[0] < Global.p0_count[1]:
		Global.p0_count[1] = Global.p0_count[0]
		Global.p0_time[1] = survival_time
	elif Global.p0_count[0] == Global.p0_count[1]:
		if Global.p0_time[0] < Global.p0_time[1]:
			Global.p0_time[1] = survival_time
	
	get_tree().change_scene("res://scenes/TitleScreen.tscn")


func _on_Snake_won():
	Global.p0_time[0] = survival_time
	Global.p0_count[1] = Global.p0_count[0]
	if Global.p0_time[0] < Global.p0_time[1]:
		Global.p0_time[1] = survival_time
