extends Item


# Called when the node enters the scene tree for the first time.
func _ready():
	self.type = G.Items.LANTERN


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func action():
	print("Lantern action!")
