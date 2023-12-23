extends Item


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.type = G.Items.LANTERN


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass


func action():
	print("Used lantern")
