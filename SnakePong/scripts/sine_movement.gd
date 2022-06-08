extends AnimatedSprite

export(bool) var isVert : bool = false
export(bool) var isHorz : bool = false
export(float) var amplitude: float = 2.5
export(float) var timespan: float = 5.0

var pos : Vector2 = position
var time = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pos = position

# Sinusodially moves the buttons
func _process(delta: float):
	time += delta
	if isVert:
		position.y = pos.y + amplitude * sin(-time * TAU / timespan)
	if isHorz:
		position.x = pos.x + amplitude * sin(-time * TAU / timespan)
