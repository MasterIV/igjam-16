extends Node

enum Direction { LEFT, RIGHT, UP, DOWN }

var directions_to_vector = {
	Enums.Direction.UP: Vector2i(0, -1),
	Enums.Direction.DOWN: Vector2i(0, 1),
	Enums.Direction.LEFT: Vector2i(-1, 0),
	Enums.Direction.RIGHT: Vector2i(1, 0),
}

var direction_to_sprite = {
	Enums.Direction.UP: "walk_up",
	Enums.Direction.DOWN: "walk_down",
	Enums.Direction.LEFT: "walk_left",
	Enums.Direction.RIGHT: "walk_right",
}
