tool
extends Container
# Creates a radial container node

export(int) var button_radius = 100 # in godot position units
export(int, 360) var whole_rotation = 0 # in degrees

# Called when the node enters the scene tree for the first time.
func _ready():
	place_buttons()

func _process(delta: float) -> void:
	place_buttons()

#Repositions the buttons
func place_buttons():
	var buttons = get_children()
	
	# Stop before we cause problems when no buttons are available
	if buttons.size() == 0:
		return
	
	# Amount to change the angle for each button
	var angle_offset = (2 * PI) / buttons.size() # in degrees
	
	var angle = 0 # in radians
	for btn in buttons: 
		# calculates the buttons location on the circle
		var circle_pos = Vector2(button_radius, 0).rotated(angle)
		
		# set button's position
		# we want to center the element on the circle. 
		# to do this we need to offset the calculated x and y respectively by half the height and width
		btn.rect_position = circle_pos.rotated(deg2rad(whole_rotation)) - (btn.get_size()/2)
		
		#Advance to next angle position
		angle += angle_offset


#utility function for adding buttons and recalculating their positions
#TODO: Should probably just use a signal to run place_button on any tree change
func add_button(btn):
	add_child(btn)
	place_buttons()
