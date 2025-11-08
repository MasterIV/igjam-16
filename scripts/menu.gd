extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func start_game(difficulty):
	Game.start(difficulty)

func _on_easy_game_pressed() -> void:
	start_game(Game.DIFFICULTY_SETTINGS.Easy)

func _on_normal_game_pressed() -> void:
	start_game(Game.DIFFICULTY_SETTINGS.Normal)

func _on_hard_game_pressed() -> void:
	start_game(Game.DIFFICULTY_SETTINGS.Hard)
