extends Label


func _ready() -> void:
	Global.connect("segment_change", self, "on_segment_change")


func on_segment_change(value):
	text = str(value)
