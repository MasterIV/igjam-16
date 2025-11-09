extends Node

var DIFFICULTY_SETTINGS = { "Easy": 2.0, "Normal": 1.5, "Hard": 1.0 }

var command_duration = DIFFICULTY_SETTINGS.Easy

var paused = false

func _process(_delta: float) -> void:
	pass
	
func start(difficulty: float) -> void:
	command_duration = difficulty;
	get_tree().change_scene_to_file("res://scenes/menu/story_intro.tscn");
	paused = false;

func lose() -> void:
	paused = true
	get_tree().current_scene.find_child("Player").die()
	await get_tree().create_timer(5).timeout
	get_tree().reload_current_scene();
	paused = false;
	
func win(next_level: PackedScene) -> void:
	get_tree().change_scene_to_packed(next_level);
	paused = false;
