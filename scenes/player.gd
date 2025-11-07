extends CharacterBody2D

@export var tile_map: TileMapLayer
@export var start_position: Vector2

enum frame_directions {DOWN, UP, LEFT, RIGHT}

var current_position = Vector2 (0, 0)

enum alive_states {ALIVE, DEAD}
var is_alive = alive_states.ALIVE
const DEATH_COUNTER = 3000
var death_time = 0

func _ready():
	current_position = start_position
	update_map_position()

func _process(delta: float) -> void:
	if is_alive == alive_states.DEAD:
		death_time += delta
		if death_time >= DEATH_COUNTER:
			# TODO game over scene
			pass

func move(dir: Vector2) -> bool:
	if is_alive == alive_states.DEAD:
		return false

	var target_tile = tile_map.get_cell_tile_data(current_position + dir)
	if target_tile.get_collision_polygons_count(0) > 0:
		return false
	current_position += dir
	update_map_position()
	var new_direction = frame_directions.LEFT
	if dir.x > 0:
		new_direction = frame_directions.RIGHT
	if dir.y < 0:
		new_direction = frame_directions.UP
	if dir.y > 0:
		new_direction = frame_directions.DOWN
	update_sprite(new_direction)

	return true

func update_map_position() -> void:
	position.x = current_position.x * 100
	position.y = current_position.y * 100
	# TODO graphics

func update_sprite(dir) -> void:
	$Sprite2D.frame = dir

func death() -> void:
	is_alive = alive_states.DEAD
