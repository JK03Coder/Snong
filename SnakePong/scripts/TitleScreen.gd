extends Control


func _unhandled_input(event: InputEvent) -> void:
	get_tree().change_scene("res://scenes/World.tscn")
