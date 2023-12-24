extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("game_pause"):
		print("game paused pressed")
		if get_tree().paused:
			print("unpausing game")
			get_tree().paused = false
		
		if not get_tree().paused:
			print("pausing game")
			get_tree().paused = true
