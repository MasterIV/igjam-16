extends CanvasLayer

@export var rules: Array[Enums.Direction]
@export var player: Player;
@export var duration = 2;

const RULE_SCENE: PackedScene = preload("res://scenes/ui/rule.tscn")

@onready var container = $MarginContainer/Instructions

var current = 0;
var progress = 0;

var directions = {
	Enums.Direction.UP: Vector2(0, -1),
	Enums.Direction.DOWN: Vector2(0, 1),
	Enums.Direction.LEFT: Vector2(-1, 0),
	Enums.Direction.RIGHT: Vector2(1, 0),
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for r in rules:
		var rule = RULE_SCENE.instantiate();
		rule.direction = r;
		container.add_child(rule)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	progress += delta;
	var rule = container.get_child(current)
	
	if progress > duration:
		rule.set_progress(0);
		player.move(directions[rule.direction]);
		
		progress = 0;
		current += 1;
		
		if current >= rules.size(): current = 0;
	else:
		rule.set_progress(100 * (progress / duration));
		
	
