extends Node2D

export(int) var init_speed : int = 200
export(int) var win_segments : int = 5
export(int) var init_segments = 20

var survival_time = 0.0

func _ready():
	Global.win_segments_multi = win_segments
	$Snake1.tail_segments = init_segments
	$Snake2.tail_segments = init_segments

func _physics_process(delta:float):
	survival_time += delta
	

func _on_Snake1_game_over():
	Global.p1lost = true
	Global.death_position = $Snake1.position + $Snake1/Head.position
	Global.p1_time[0] = survival_time
	Global.p2_time[0] = survival_time
	
	if Global.p2_count[0] < Global.p2_count[1]:
		Global.p2_count[1] = Global.p2_count[0]
		Global.p2_time[1] = survival_time
	elif Global.p2_count[0] == Global.p2_count[1]:
		if Global.p2_time[0] < Global.p2_time[1]:
			Global.p2_time[1] = survival_time
	
	if Global.p1_count[0] < Global.p1_count[1]:
		Global.p1_count[1] = Global.p1_count[0]
		Global.p1_time[1] = survival_time
	elif Global.p1_count[0] == Global.p1_count[1]:
		if Global.p1_time[0] < Global.p1_time[1]:
			Global.p1_time[1] = survival_time
	
	get_tree().change_scene("res://scenes/TitleScreen.tscn")

func _on_Snake2_game_over():
	Global.p2lost = true
	Global.death_position = $Snake2.position + $Snake2/Head.position
	Global.p1_time[0] = survival_time
	Global.p2_time[0] = survival_time
	
	if Global.p1_count[0] < Global.p1_count[1]:
		Global.p1_count[1] = Global.p1_count[0]
		Global.p1_time[1] = survival_time
	elif Global.p1_count[0] == Global.p1_count[1]:
		if Global.p1_time[0] < Global.p1_time[1]:
			Global.p1_time[1] = survival_time
	
	if Global.p2_count[0] < Global.p2_count[1]:
		Global.p2_count[1] = Global.p2_count[0]
		Global.p2_time[1] = survival_time
	elif Global.p2_count[0] == Global.p2_count[1]:
		if Global.p2_time[0] < Global.p2_time[1]:
			Global.p2_time[1] = survival_time
	
	get_tree().change_scene("res://scenes/TitleScreen.tscn")



func _on_Snake1_won():
	Global.won = true
	Global.p1_time[0] = survival_time
	Global.p1_count[1] = Global.p1_count[0]
	if Global.p1_time[0] < Global.p1_time[1]:
		Global.p1_time[1] = Global.p1_time[0]
	
	get_tree().change_scene("res://scenes/TitleScreen.tscn")


func _on_Snake2_won():
	Global.won = true
	Global.p2_time[0] = survival_time
	Global.p2_count[1] = Global.p2_count[0]
	if Global.p2_time[0] < Global.p2_time[1]:
		Global.p2_time[1] = Global.p2_time[0]
	
	get_tree().change_scene("res://scenes/TitleScreen.tscn")
