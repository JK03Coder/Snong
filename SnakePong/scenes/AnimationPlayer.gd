extends AnimationPlayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	play("normal")

func _on_Snake_game_over():
	play("death")

#func animation_finished(anim_name: String):
#	if anim_name == "death":
#		get_tree().change_scene("res://scenes/TitleScreen.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
