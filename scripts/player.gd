class_name Player
extends CharacterBody2D

@export var tile_map: TileMapLayer

var target_destination: Vector2 = position;
@onready var sound_player = $AudioStreamPlayer2D

func _ready() -> void:
	target_destination = position
	sound_player.volume_db = -6.0
	sound_player.play()
	load("res://assets/sounds/Down.mp3")
	load("res://assets/sounds/Up.mp3")
	load("res://assets/sounds/Right.mp3")
	load("res://assets/sounds/Left.mp3")

func _physics_process(_delta):
	if position == target_destination:
		return
		
	var movement = target_destination - position
	move_and_collide(movement)

func move(dir: Enums.Direction) -> void:
	var current_tile = tile_map.local_to_map(position)
	var target_tile = current_tile + Enums.directions_to_vector[dir]

	var taget_data = tile_map.get_cell_tile_data(target_tile)
	if taget_data.get_collision_polygons_count(0) > 0:
		return
		
	update_sprite(dir)
	var tween = create_tween()
	tween.tween_property(self, "target_destination", tile_map.map_to_local(target_tile), 0.5)
	if randi() % 100 +1 >= 90:
		var sound_file = ""
		match dir:
			Enums.Direction.UP:
				sound_file = "res://assets/sounds/Up.mp3"
			Enums.Direction.DOWN:
				sound_file = "res://assets/sounds/Down.mp3"
			Enums.Direction.LEFT:
				sound_file = "res://assets/sounds/Left.mp3"
			Enums.Direction.RIGHT:
				sound_file = "res://assets/sounds/Right.mp3"
		sound_player.stream = load(sound_file)
		sound_player.play()

func update_sprite(dir: Enums.Direction) -> void:
	$AnimatedSprite2D.play(Enums.direction_to_sprite[dir])
		
