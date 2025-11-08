extends Node

var DIFFICULTY_SETTINGS = { "Easy": 2.0, "Normal": 1.5, "Hard": 1.0 }

var COMMAND_DURATION = DIFFICULTY_SETTINGS.Easy

var paused = false

func lose() -> void:
	get_tree().reload_current_scene();
	
func win(next_level: PackedScene) -> void:
	get_tree().change_scene_to_packed(next_level);
