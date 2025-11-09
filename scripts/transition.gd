class_name Transition
extends AnimationPlayer

func _ready() -> void:
	play("fade_in")

func set_rect_visibility(v: bool):
	$CanvasLayer/ColorRect.visible = v
