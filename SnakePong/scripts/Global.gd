extends Node

signal segment_change(num_of_segments)

var ball_position : Vector2
var num_of_segments : int setget set_segments

var current_scene = 0

var single_seg_per = 0
var single_time = 0

func set_segments(value):
	num_of_segments = value
	emit_signal("segment_change", num_of_segments)
