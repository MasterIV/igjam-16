extends VBoxContainer

@export var direction : Enums.Direction = Enums.Direction.UP;

var texture_regions = {
	Enums.Direction.RIGHT: Rect2(0, 0, 100, 100),
	Enums.Direction.LEFT: Rect2(100, 0, 100, 100),
	Enums.Direction.DOWN: Rect2(200, 0, 100, 100),
	Enums.Direction.UP: Rect2(300, 0, 100, 100),
}

var opposite_direction = {
	Enums.Direction.UP: Enums.Direction.DOWN,
	Enums.Direction.DOWN: Enums.Direction.UP,
	Enums.Direction.LEFT: Enums.Direction.RIGHT,
	Enums.Direction.RIGHT: Enums.Direction.LEFT,
}

@export var icon : TextureRect;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	icon.texture = icon.texture.duplicate()
	icon.texture.region = texture_regions[direction];

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass # fill progress bar?

func _on_button_button_up() -> void:
	direction = opposite_direction[direction];
	icon.texture.region = texture_regions[direction];
