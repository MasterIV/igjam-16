class_name Enemy
extends Area2D

@export var path: Array[Enums.Direction];
@export var tile_map: TileMapLayer

var current = 0;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _on_body_entered(body: Node2D) -> void:
	Game.lose();

func move() -> void:
	var dir = path[current]
	var current_tile = tile_map.local_to_map(position)
	var target_tile = current_tile + Enums.directions_to_vector[dir]

	var taget_data = tile_map.get_cell_tile_data(target_tile)
	if taget_data.get_collision_polygons_count(0) > 0:
		return
		
	update_sprite(dir)
	var tween = create_tween()
	tween.tween_property(self, "position", tile_map.map_to_local(target_tile), 0.5)
	
	current += 1;
	if current >= path.size(): current = 0;

func update_sprite(dir: Enums.Direction) -> void:
	$AnimatedSprite2D.play(Enums.direction_to_sprite[dir])
