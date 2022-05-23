extends ColorRect

var move_range = 600-150 # screen height - paddle height

func _process(delta):
	var processed_y = Global.ballPosY
	processed_y = processed_y / 600 * move_range

	var processed_vector = Vector2(get_position().x, processed_y)
	set_position(processed_vector)
