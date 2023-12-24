extends Node

# Important resources
var dialogue_scene = preload("res://utility/DialogueBox.tscn")
var default_tool = preload("res://objects/Item.tscn")
var lantern = preload("res://objects/Lantern.tscn")

# Important enums
enum Items {
	NONE,
	LANTERN
}

func create_equipment(type : int) -> Item:
	if type == Items.NONE:
		print("Creating NONE")
		return default_tool.instantiate()
	
	if type == Items.LANTERN:
		print("Creating LANTERN")
		return lantern.instantiate()
	
	print("Improper ID, creating NONE by default.")
	return default_tool.instantiate()
