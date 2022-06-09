extends Label

onready var time = 0
var mins = 0
var secs = 0
var format_string = "%02d:%02d"

func _ready():
	text = format_string % [0, 0]

func _process(delta):
	time = int(get_parent().survival_time)
	mins = time/60
	secs = time%60
	text = format_string%[mins, secs]
