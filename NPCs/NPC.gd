extends Sprite

var quest_path = "res://NPCs/test_script.json"
var quest_result

var quest_dialogue

# Called when the node enters the scene tree for the first time.
func _ready():
	var quest_file = File.new()
	
	# Open up our quest file and see if there are any errors.
	var file_status = quest_file.open(quest_path, File.READ)
	var quest_raw
	if file_status == OK:
		quest_raw = quest_file.get_as_text()
	else:
		print("File failed to open with status code: " + file_status)
	quest_file.close()
	
	# Parse the quest data and check for errors.
	var quest_json_return = JSON.parse(quest_raw)
	if quest_json_return.error == OK:
		quest_result = quest_json_return.result
	else:
		print(quest_json_return.error_string)
	quest_dialogue = quest_result["dialogue"]
	print(quest_dialogue[0])

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
