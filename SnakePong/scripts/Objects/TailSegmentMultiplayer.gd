extends Area2D

var turns_dir = []
var turns_loc = []
onready var cur_dir : Vector2
onready var speed : int = get_parent().speed
onready var turn_rate : float = get_parent().turn_rate


func _ready():
	connect("area_entered", self, "on_area_entered")
	connect("body_exited", self, "on_body_exited")
	$BodyAnimation.set_frame(floor(rand_range(0.1,7.9)))
	$BodyAnimation.play("default")

func _process(delta):
	speed = get_parent().speed

func change_dir() -> void:
	cur_dir = turns_dir[0]
	turns_dir.pop_front()
	turns_loc.pop_front()


func add_turn(head_pos: Vector2, dir: Vector2) -> void:
	turns_loc.append(head_pos)
	turns_dir.append(dir)


func on_area_entered(area: Area2D) -> void:
	if area.name == "Head":
		get_parent().death()


func on_body_exited(body: Node) -> void:
	if body.name == "Ball":
		SfxMan.play_collisionSFX()
		get_parent().remove_tail()


func _physics_process(delta: float) -> void:

	# get the next position to move during this frame
	var next_pos = position + (cur_dir * delta * speed)

	# if the snake head has turned ahead then check if you've hit that turn location
	if turns_dir.size() > 0:
		match cur_dir:
			# for every direction check if you've past the turning point
			# if you've past the turn point move back and forward the amount you should have
			# also change direction
			Vector2.RIGHT:
				if next_pos.x > turns_loc[0].x:
					var dif = next_pos.x - turns_loc[0].x
					next_pos.x -= dif
					change_dir()
					next_pos += cur_dir * abs(dif)
			Vector2.LEFT:
				if next_pos.x < turns_loc[0].x:
					var dif = next_pos.x - turns_loc[0].x
					next_pos.x -= dif
					change_dir()
					next_pos += cur_dir * abs(dif)
			Vector2.UP:
				if next_pos.y < turns_loc[0].y:
					var dif = next_pos.y - turns_loc[0].y
					next_pos.y -= dif
					change_dir()
					next_pos += cur_dir * abs(dif)
			Vector2.DOWN:
				if next_pos.y > turns_loc[0].y:
					var dif = next_pos.y - turns_loc[0].y
					next_pos.y -= dif
					change_dir()
					next_pos += cur_dir * abs(dif)

	# then finally move where you're supposed to move
	position = next_pos
