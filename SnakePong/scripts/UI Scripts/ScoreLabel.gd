extends Label

export(int) var player_id: int = 0
export(bool) var is_best: bool = false
var score = 0

func _ready():
	match player_id:
		0:
			if is_best:
				score = Global.p0_count[1] - Global.win_segments_single
			else:
				score = Global.p0_count[0] - Global.win_segments_single
		1:
			if is_best:
				score = Global.p1_count[1] - Global.win_segments_multi
			else:
				score = Global.p1_count[0] - Global.win_segments_multi
		2:
			if is_best:
				score = Global.p2_count[1] - Global.win_segments_multi
			else:
				score = Global.p2_count[0] - Global.win_segments_multi
	
	text = "%3d in" % score

