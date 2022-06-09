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
onready var pressplayer = $Labels/PressPlayer

func _ready() -> void:
	current_screen = Global.current_scene
	arrowleft.play("idle")
	arrowright.play("idle")
	
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
	

func _process(delta: float) -> void:
	# Swaps between modes
	if start_delay.is_stopped():
		if Input.is_action_just_pressed("move_left"):
			current_screen -= 1
			if current_screen < 0:
				current_screen = 1
			arrowleft.play("hit")
			start_delay.start()
		elif Input.is_action_just_pressed("move_right"):
			current_screen += 1
			if current_screen > 1:
				current_screen = 0
			
			arrowright.play("hit")
			start_delay.start()
	# Changed scene to singleplayer
	if current_screen == 0:
		subtitle_label.text = "Singleplayer"
		subtitle_label.self_modulate = Color(0.34902, 0.933333, 0.32549)
		pressplayer.play("Pinging")
		if start_delay.is_stopped():
			if Input.is_action_just_pressed("move_down"):
				Global.current_scene = 0
				get_tree().change_scene(singleplayer_scene)
	# Changed scene to multiplayer
	elif current_screen == 1:
		subtitle_label.text = "Multiplayer"
		subtitle_label.self_modulate = Color(0.831373, 0.231373, 0.886275)
		pressplayer.play("Pinging")
		if start_delay.is_stopped():
			if Input.is_action_pressed("move_down"):
				Global.current_scene = 1
				get_tree().change_scene(multiplayer_scene)
	# Changed scene to scoreboard

# For when the arrow has finished doing its hit anim
func _on_ArrowLeft_animation_finished():
	if arrowleft.animation == "hit":
		arrowleft.animation = "idle"
func _on_ArrowRight_animation_finished():
	if arrowright.animation == "hit":
		arrowright.animation = "idle"
