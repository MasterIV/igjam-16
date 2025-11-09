extends Node

var DIFFICULTY_SETTINGS = { "Easy": 2.0, "Normal": 1.5, "Hard": 1.0 }
const TRANSITION_SCENE: PackedScene = preload("res://scenes/animation/transition.tscn")

var command_duration = DIFFICULTY_SETTINGS.Easy

var paused = false

func _process(_delta: float) -> void:
	pass
	
func start(difficulty: float) -> void:
	command_duration = difficulty;
	get_tree().change_scene_to_file("res://scenes/menu/story_intro.tscn");
	paused = false;

func lose() -> void:
	paused = true;
	get_tree().current_scene.find_child("Player").die();
	await get_tree().create_timer(5).timeout;
	await fade_out();
	get_tree().reload_current_scene();
	paused = false;
	
func win(next_level: PackedScene) -> void:
	paused = true;
	get_tree().current_scene.find_child("Player").victory();
	await get_tree().create_timer(2).timeout;
	await fade_out();
	get_tree().change_scene_to_packed(next_level);
	paused = false;

func fade_out() -> void:
	var transition: Transition = get_tree().current_scene.find_child("Transition")
	if transition == null: return;
	transition.play("fade_out");
	await transition.animation_finished;
	
