extends Area2D

var turns_dir = []
var turns_loc = []
onready var cur_dir : Vector2
onready var speed : int = get_parent().speed
onready var turn_rate : float = get_parent().turn_rate


func _ready():
	connect("area_entered", self, "on_area_entered")


func change_dir() -> void:
	cur_dir = turns_dir[0]
	turns_dir.pop_front()
	turns_loc.pop_front()


func add_turn(head_pos: Vector2, dir: Vector2) -> void:
	turns_loc.append(head_pos)
	turns_dir.append(dir)


func on_area_entered(area: Area2D) -> void:
	if area.name == "Head":
		get_parent().hit_self()


func _physics_process(delta: float) -> void:
	# get the next position to set the snake tail segment
	var next_pos : Vector2 = position + cur_dir * delta * speed

	# if the snake head has turned ahead then check if you've hit that turn location
	if turns_dir.size() > 0:
		# get the vector of how far it will pass over the turn location
		# which will also point in the same direction you're going when you pass the turn location
		var over_pos : Vector2 = turns_loc[0].direction_to(next_pos)
		# if in the next frame you're past the turn location
		if over_pos.normalized() == cur_dir:
			# the next_position will be from that turn location plus how much
			# you would have past the turning point
			next_pos = turns_loc[0] + (turns_dir[0] * over_pos.length())
			change_dir()

	# then finally set the next position to where you should be
	position = next_pos
