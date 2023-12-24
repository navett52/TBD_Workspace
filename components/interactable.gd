@tool
class_name Interactable extends Node


var interactee: Node
var is_interacting: bool
var in_interact_range: bool = false


func _enter_tree():
	_get_configuration_warnings()


func _get_configuration_warnings():
	print("running _get_configuration_warnings...")
	var warnings = []
	
	if get_children().size() < 1 or not get_children().any(
		func(c):
			print(c.name)
			c is Area2D
	):
		print("no children...")
		warnings.append("This node has no area, so it won't know when something is within range to interact.\nConsider adding an Area2D and setting its shape to most appropriately represent the interaction range of this object.")
	
	return warnings
