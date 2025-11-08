class_name Player
extends CharacterBody2D

@export var tile_map: TileMapLayer
@export var start_position: Vector2

var directions = {
	Enums.Direction.UP: Vector2i(0, -1),
	Enums.Direction.DOWN: Vector2i(0, 1),
	Enums.Direction.LEFT: Vector2i(-1, 0),
	Enums.Direction.RIGHT: Vector2i(1, 0),
}

var sprites = {
	Enums.Direction.UP: "walk_up",
	Enums.Direction.DOWN: "walk_down",
	Enums.Direction.LEFT: "walk_left",
	Enums.Direction.RIGHT: "walk_right",
}

var target_destination: Vector2 = position;

func _ready() -> void:
	target_destination = position

func _physics_process(delta):
	if position == target_destination:
		return
		
	var movement = target_destination - position
	move_and_collide(movement)

func move(dir: Enums.Direction) -> void:
	var current_tile = tile_map.local_to_map(position)
	var target_tile = current_tile + directions[dir]

	var taget_data = tile_map.get_cell_tile_data(target_tile)
	if taget_data.get_collision_polygons_count(0) > 0:
		return
		
	update_sprite(dir)
	var tween = create_tween()
	tween.tween_property(self, "target_destination", tile_map.map_to_local(target_tile), 0.5)
	
	await tween.finished
	# we can youse a custom data layer on the tileset to check for traps or goal here?
	print("moved") 

func update_sprite(dir: Enums.Direction) -> void:
	$AnimatedSprite2D.play(sprites[dir])
		
