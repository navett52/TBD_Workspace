extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("ui_inventory"):
		self.visible = true
		get_tree().paused = true
	else:
		self.visible = false
		get_tree().paused = false
