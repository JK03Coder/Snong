extends Node2D

export(String, FILE, "*.tscn,*.scn") var title
var survival_time = 0.0
export(int) var win_segments = 3
export(int) var init_segments = 35

func _ready():
	Global.win_segments_single = win_segments
	$Snake.tail_segments = init_segments

func _physics_process(delta: float):
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
	
	get_tree().change_scene(title)


func _on_Snake_won():
	Global.won = true
	Global.p0_time[0] = survival_time
	Global.p0_count[1] = Global.p0_count[0]
	if Global.p0_time[0] < Global.p0_time[1]:
		Global.p0_time[1] = Global.p0_time[0]
	
	get_tree().change_scene("res://scenes/TitleScreen.tscn")
