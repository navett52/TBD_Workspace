extends Control

export(Color) var hover_color
export(int, "None", "Lantern") var assigned_tool
var last_tool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_slot(assigned_tool)
	last_tool = assigned_tool
	print("Assigned Tool: ", assigned_tool)
	print("Last Tool: ", last_tool)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not get_parent().visible:
		self.modulate = Color.white
	
	if assigned_tool != last_tool:
		print("Tool changed!")
		set_slot(assigned_tool)
		last_tool = assigned_tool


func _on_RadialOption_mouse_entered() -> void:
	self.modulate = hover_color


func _on_RadialOption_mouse_exited() -> void:
	self.modulate = Color.white


func _on_RadialOption_gui_input(event):
	if event is InputEventMouseButton:
		print("Assigned Tool: ", assigned_tool)
		print("Last Tool: ", last_tool)


func set_slot(tool_id : int):
	print("Changing tool from " + str(last_tool) + " to " + str(tool_id))
	var new_tool = G.create_equipment(tool_id)
	print("New tools type: " + str(new_tool.type))
	assigned_tool = new_tool.type
	get_node("Border/Icon").texture = new_tool.get_node("Sprite").texture
	# Below is just for debug while there are no actual sprites for things.
	get_node("Border/Icon").modulate = new_tool.get_node("Sprite").modulate
