extends CanvasLayer

@export var rules: Array[Enums.Direction]
@export var player: Player;

const RULE_SCENE: PackedScene = preload("res://scenes/ui/rule.tscn")

@onready var container = $MarginContainer/Instructions

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for r in rules:
		var rule = RULE_SCENE.instantiate();
		rule.direction = r;
		container.add_child(rule)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
