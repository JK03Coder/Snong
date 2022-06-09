extends Label

export(int) var player_id: int = 0
export(int) var is_best: int = 0
var score = 0

func _ready():
	match player_id:
		0:
			if is_best:
				score = Global.p0_count[1]
			else:
				score = Global.p0_count[0]
		1:
			if is_best:
				score = Global.p1_count[1]
			else:
				score = Global.p1_count[0]
		2:
			if is_best:
				score = Global.p2_count[1]
			else:
				score = Global.p2_count[0]
	
	text = "%02d in" % score

