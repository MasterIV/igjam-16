extends CharacterBody2D

@export var step_time = 5000

var time_elapsed = 0

func _ready():
	pass

func _phyics_process(delta):
	time_elapsed += delta
	
	if time_elapsed >= step_time:
		# do stuff
		pass
	pass
