extends Node

signal segment_change(num_of_segments, p_id)

var ball_position : Vector2
var p0_segments : int setget set_segments_0
var p1_segments : int setget set_segments_1
var p2_segments : int setget set_segments_2
var num_segments_multiplayer : Array setget set_segments_multiplayer

var win_segments_single: int = 3
var win_segments_multi: int = 5

var current_scene = 0
# Arrays, for [most recent value, best value]:
#     count = segment count; time = time before death.
var p0_count = [38,38]
var p0_time = [0.0,0.0]
var p1_count = [20,20]
var p1_time = [0.0,0.0]
var p2_count = [20,20]
var p2_time = [0.0,0.0]

var p0lost: bool = false
var p1lost : bool = false
var p2lost : bool = false
var death_position : Vector2 = Vector2(384.0,256.0)
var won : bool = false

func set_segments_multiplayer(arr: Array):
	num_segments_multiplayer = arr[0]

func set_segments_0(value):
	p0_segments = value
	p0_count[0] = p0_segments
	emit_signal("segment_change", p0_segments, 0)
func set_segments_1(value):
	p1_segments = value
	p1_count[0] = p1_segments
	emit_signal("segment_change", p1_segments, 1)
func set_segments_2(value):
	p2_segments = value
	p2_count[0] = p2_segments
	emit_signal("segment_change", p2_segments, 2)
	
