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

func _ready() -> void:
	current_screen = Global.current_scene
	$AudioStreamPlayer.play()
	$Labels/PressPlayer.play("Pinging")
	arrowleft.play("idle")
	arrowright.play("idle")

func _process(delta: float) -> void:
	# Swaps between modes
	if start_delay.is_stopped():
		if Input.is_action_just_pressed("move_left"):
			if current_screen == 1:
				current_screen = 0
			elif current_screen == 0:
				current_screen = 1
			arrowleft.play("hit")
			start_delay.start()
		elif Input.is_action_just_pressed("move_right"):
			if current_screen == 0:
				current_screen = 1
			elif current_screen == 1:
				current_screen = 0
			arrowright.play("hit")
			start_delay.start()

	# Changed scene to singleplayer
	if current_screen == 0:
		subtitle_label.text = "Singleplayer"
		if start_delay.is_stopped():
			if Input.is_action_just_pressed("move_down"):
				Global.current_scene = 0
				get_tree().change_scene(singleplayer_scene)
	# Changed scene to multiplayer
	elif current_screen == 1:
		subtitle_label.text = "Multiplayer"
		if start_delay.is_stopped():
			if Input.is_action_pressed("p1_down") and Input.is_action_pressed("p2_down"):
				Global.current_scene = 1
				get_tree().change_scene(multiplayer_scene)

# For when the arrow has finished doing its hit anim
func _on_ArrowLeft_animation_finished():
	if arrowleft.animation == "hit":
		arrowleft.animation = "idle"
func _on_ArrowRight_animation_finished():
	if arrowright.animation == "hit":
		arrowright.animation = "idle"
