extends Control

export(String, FILE, "*.tscn,*.scn") var main_scene

onready var start_delay := $start_delay

func _ready() -> void:
	$AnimationPlayer.play("Pinging")


func _process(delta: float) -> void:
	if start_delay.is_stopped() and Input.is_action_just_pressed("start_game"):
		#SfxMan.play_coinsfx()
		get_tree().change_scene(main_scene)
