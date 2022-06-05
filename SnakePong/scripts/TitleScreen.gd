extends Control

onready var start_delay := false

func _ready() -> void:
	yield(get_tree().create_timer(1), "timeout")
	start_delay = true


func _unhandled_input(event: InputEvent) -> void:
	if start_delay:
		get_tree().change_scene("res://scenes/World.tscn")
