extends Label

export(int) var player_id : int = 0
export(bool) var is_remaining : bool = false
export(int) var init_seg : int = 20

var func_connect = "p0_segment"
var win_seg

func _ready() -> void:
	Global.connect("segment_change", self, "on_segment_change")
	win_seg = get_parent().win_segments
	if is_remaining:
		text = str(get_parent().init_segments)

func on_segment_change(seg_value, p_id):
	if p_id == player_id:
		if is_remaining:
			text = str(seg_value)
		else:
			text = str(seg_value-win_seg)
