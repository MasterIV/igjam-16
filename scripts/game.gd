extends Node

var DIFFICULTY_SETTINGS = { "Easy": 2.0, "Normal": 1.5, "Hard": 1.0 }

var COMMAND_DURATION = DIFFICULTY_SETTINGS.Easy

var paused = false

func _process(delta: float) -> void:
	pass
	
func start(difficulty: float) -> void:
	COMMAND_DURATION = difficulty;
	get_tree().change_scene_to_file("res://scenes/menu/story_intro.tscn");
	paused = false;

func lose() -> void:
	get_tree().reload_current_scene();
	paused = false;
	
func win(next_level: PackedScene) -> void:
	get_tree().change_scene_to_packed(next_level);
	paused = false;
