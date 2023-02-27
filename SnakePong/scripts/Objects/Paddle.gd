extends KinematicBody2D

export(float) var speed : float = 30.0
export(float) var upper_limit : float = 44
var lower_limit : float = 400

var direction : Vector2


func _ready():
	var screensize = get_viewport().size
	lower_limit = 512 - upper_limit

func _physics_process(_delta: float) -> void:
	if Global.ball_position.y > upper_limit and Global.ball_position.y < lower_limit:
		global_position.y = Global.ball_position.y
		
