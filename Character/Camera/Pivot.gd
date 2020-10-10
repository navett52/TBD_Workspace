extends Position2D

onready var parent = self.get_parent()

# Called when the node enters the scene tree for the first time.
func _ready():
	update_pivot_angle()

func _physics_process(delta):
	update_pivot_angle()

func update_pivot_angle():
	self.rotation = parent.look_direction.angle()
