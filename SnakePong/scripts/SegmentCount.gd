extends Label

export(int) var player_id : int = 0
var func_connect = "p0_segment"

func _ready() -> void:
	Global.connect("segment_change", self, "on_segment_change")

func on_segment_change(seg_value, p_id):
	if p_id == player_id:
		text = str(seg_value)
