extends Control

export(String, FILE, "*.tscn,*.scn") var singleplayer_scene
export(String, FILE, "*.tscn,*.scn") var multiplayer_scene

# 3 screens will exist:
#	Singleplayer (with best time under the play prompt)
#	Multiplayer (with best segment count and time for each side)
#	High score tab, with best times for both single and multiplayer ??
var current_screen = 0

onready var start_delay := $start_delay
onready var title_label := $Labels/TitleLabel
onready var subtitle_label := $Labels/SubtitleLabel
onready var arrowleft := $Labels/SubtitleLabel/ArrowLeft
onready var arrowright := $Labels/SubtitleLabel/ArrowRight
onready var blue_confetti := $Particles/BlueConfetti
onready var red_confetti := $Particles/RedConfetti
onready var green_confetti := $Particles/GreenConfetti
onready var win_confetti := $Particles/WinConfetti
onready var pressplayer := $Labels/PressPlayer
onready var panelsingle := $PanelSingleplayer
onready var panelmulti := $PanelMultiplayer


func _ready() -> void:
	current_screen = Global.current_scene
	arrowleft.play("idle")
	arrowright.play("idle")
	
	if Global.won:
		win_confetti.emitting = true
		Global.won = false
	if Global.p0lost:
		green_confetti.position = Global.death_position
		green_confetti.emitting = true
		Global.p0lost = false
	elif Global.p1lost:
		red_confetti.position = Global.death_position
		red_confetti.emitting = true
		Global.p1lost = false
	elif Global.p2lost:
		blue_confetti.position = Global.death_position
		blue_confetti.emitting = true
		Global.p2lost = false
	

func _process(_delta: float) -> void:
	# Swaps between modes
	if start_delay.is_stopped():
		if Input.is_action_just_pressed("swap_mode"):
			current_screen += 1
	# Changes scene to singleplayer on input
	if current_screen % 2 == 0:
		subtitle_label.text = "Singleplayer"
		subtitle_label.self_modulate = Color(0.34902, 0.933333, 0.32549)
		pressplayer.play("Pinging")
		panelmulti.visible = false
		panelsingle.visible = true
		if start_delay.is_stopped():
			if Input.is_action_just_pressed("press_play"):
				Global.current_scene = 0
				SfxMan.play_clicksfx()
				get_tree().change_scene(singleplayer_scene)
	# Changes scene to multiplayer on input
	elif current_screen % 2 == 1:
		subtitle_label.text = "Multiplayer"
		subtitle_label.self_modulate = Color(0.831373, 0.231373, 0.886275)
		pressplayer.play("Pinging")
		panelsingle.visible = false
		panelmulti.visible = true
		if start_delay.is_stopped():
			if Input.is_action_pressed("press_play"):
				Global.current_scene = 1
				SfxMan.play_clicksfx()
				get_tree().change_scene(multiplayer_scene)

# For when the arrow has finished doing its hit anim
func _on_ArrowLeft_animation_finished():
	if arrowleft.animation == "hit":
		arrowleft.animation = "idle"
func _on_ArrowRight_animation_finished():
	if arrowright.animation == "hit":
		arrowright.animation = "idle"

func _input(event):
	if event.is_action_pressed("fullscreen"):
		OS.window_fullscreen = !OS.window_fullscreen
	if event.is_action_pressed("close") && OS.window_fullscreen:
		get_tree().quit()
