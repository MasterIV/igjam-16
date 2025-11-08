extends CanvasLayer

@export var rules: Array[Enums.Direction]
@export var player: Player;
@export var enemies: Array[Enemy];

var duration = Game.command_duration;

const RULE_SCENE: PackedScene = preload("res://scenes/ui/rule.tscn")

@onready var container = $MarginContainer/Instructions

var current = 0;
var progress = 0;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for r in rules:
		var rule = RULE_SCENE.instantiate();
		rule.direction = r;
		container.add_child(rule)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Game.paused: return;
	
	progress += delta;
	var rule = container.get_child(current)
	
	if progress > duration:
		rule.set_progress(0);
		player.move(rule.direction);
		for e in enemies: e.move();
		
		progress = 0;
		current += 1;
		
		if current >= rules.size(): current = 0;
	else:
		rule.set_progress(100 * (progress / duration));
		
	
