extends Label

export(int) var player_id: int = 0
export(bool) var is_best: bool = false
var time = 0
var mins : int = 0
var secs : int = 0

func _ready():
	if player_id == 0:
		if is_best:
			time = int(Global.p0_time[1])
		else:
			time = int(Global.p0_time[0])
	elif player_id == 1:
		if is_best:
			time = int(Global.p1_time[1])
		else:
			time = int(Global.p1_time[0])
	elif player_id == 2:
		if is_best:
			time = int(Global.p2_time[1])
		else:
			time = int(Global.p2_time[0])
	mins = time/60
	secs = time%60
	text = "%02d:%02d"%[mins, secs]
