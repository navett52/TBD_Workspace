extends Node2D
class_name Item

var type: int

# Called when the node enters the scene tree for the first time.
func _ready():
	self.type = G.Items.NONE


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		self.action()


func action():
	print("No action.")
