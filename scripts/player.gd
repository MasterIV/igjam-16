class_name Player
extends CharacterBody2D

@export var tile_map: TileMapLayer
@export var start_position: Vector2

enum frame_directions {DOWN, UP, LEFT, RIGHT}

var current_position = Vector2 (0, 0)
var tile_offset = Vector2(0.0, 0.0)

enum move_states {STANDING, MOVING}
var is_moving = move_states.STANDING
var move_dir = Vector2(0, 0)
var move_time = 0
const MOVE_SPEED = 1000

enum alive_states {ALIVE, DEAD}
var is_alive = alive_states.ALIVE
const DEATH_COUNTER = 3000
var death_time = 0

func _ready():
	current_position = start_position
	update_map_position()
	update_sprite(Vector2(0, 1))

func _physics_process(delta: float) -> void:
	if is_alive == alive_states.DEAD:
		death_time += delta
		if death_time >= DEATH_COUNTER:
			# TODO game over scene
			pass
	if is_moving == move_states.MOVING:
		move_time += delta
		if move_time >= MOVE_SPEED:
			move_time = 0
			is_moving = move_states.STANDING
			update_sprite(tile_offset)
			clear_offset()
			pass
		tile_offset.x = lerp(0.0, move_dir.x, move_time / MOVE_SPEED)
		tile_offset.y = lerp(0.0, move_dir.y, move_time / MOVE_SPEED)
		update_map_position()

func move(dir: Vector2) -> bool:
	if is_alive == alive_states.DEAD:
		return false

	var target_tile = tile_map.get_cell_tile_data(current_position + dir)
	if target_tile.get_collision_polygons_count(0) > 0:
		return false
	move_dir = dir * 100
	is_moving = move_states.MOVING
	update_sprite(dir)

	return true

func update_map_position() -> void:
	position.x = current_position.x * 100 + tile_offset.x
	position.y = current_position.y * 100 + tile_offset.y

func clear_offset() -> void:
	if tile_offset.x > 0:
		current_position.x += 1
	if tile_offset.x < 0:
		current_position.x -= 1
	if tile_offset.y > 0:
		current_position.y += 1
	if tile_offset.y < 0:
		current_position.y -= 1
	tile_offset = Vector2(0.0, 0.0)
	update_map_position()

func update_sprite(dir) -> void:
	var new_direction = frame_directions.LEFT
	if dir.x > 0:
		new_direction = frame_directions.RIGHT
	if dir.y < 0:
		new_direction = frame_directions.UP
	if dir.y > 0:
		new_direction = frame_directions.DOWN

	var animation = ""
	if is_moving == move_states.STANDING:
		animation += "look_"
	else:
		animation += "walk_"
	match new_direction:
		frame_directions.UP:
			animation += "up"
		frame_directions.DOWN:
			animation += "down"
		frame_directions.LEFT:
			animation += "left"
		frame_directions.RIGHT:
			animation += "right"
	$AnimatedSprite2D.play(animation)

func death() -> void:
	is_alive = alive_states.DEAD
