extends Area2D

var turns_dir = []
var turns_loc = []
onready var cur_dir : Vector2
onready var move_dir : Vector2 = cur_dir
onready var speed : int = get_parent().speed
onready var turn_rate : float = get_parent().turn_rate


func change_dir() -> void:
	cur_dir = turns_dir[0]
	turns_dir.pop_front()
	turns_loc.pop_front()


func add_turn(head_pos: Vector2, dir: Vector2) -> void:
	turns_loc.append(head_pos)
	turns_dir.append(dir)


func _physics_process(delta: float) -> void:
	# if the snake head has turned ahead then check if you've hit that turn location
	if turns_dir.size() > 0:
		match cur_dir:
			Vector2.RIGHT:
				if position.x >= turns_loc[0].x:
					change_dir()
			Vector2.LEFT:
				if position.x <= turns_loc[0].x:
					change_dir()
			Vector2.UP:
				if position.y <= turns_loc[0].y:
					change_dir()
			Vector2.DOWN:
				if position.y >= turns_loc[0].y:
					change_dir()

	move_dir.x = move_toward(move_dir.x, cur_dir.x, turn_rate)
	move_dir.y = move_toward(move_dir.y, cur_dir.y, turn_rate)
	position += move_dir * delta * speed
