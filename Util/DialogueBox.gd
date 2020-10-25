extends NinePatchRect
class_name Dialogue

signal started_dialogue
signal finished_dialogue

var dialogue_path: String
var dialogue: Array
var total_dialogue_count: int
var current_dialogue_index: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	emit_signal("started_dialogue")
	dialogue = _fetch_dialogue()
	assert(dialogue.size() > 0, "Dialogue received has no dialogue.")
	if (dialogue.size() > 0):
		total_dialogue_count = dialogue.size()
		$MarginContainer/RichTextLabel.bbcode_text = dialogue[current_dialogue_index]
	else:
		print("Dialogue received has no dialogue.")

func progress_dialogue() -> void:
	current_dialogue_index += 1
	if current_dialogue_index < total_dialogue_count:
		$MarginContainer/RichTextLabel.bbcode_text = dialogue[current_dialogue_index]
	else:
		emit_signal("finished_dialogue")
		queue_free()

func _fetch_dialogue() -> Array:
	var dialogue_file: File = File.new()
	
	# Open up our quest file and see if there are any errors.
	var file_status: int = dialogue_file.open(dialogue_path, File.READ)
	var quest_raw: String
	assert(file_status == OK, "Failed to open file from path [\"" + dialogue_path + "\"]\nFile Status: " + str(file_status))
	if file_status == OK:
		quest_raw = dialogue_file.get_as_text()
	else:
		print("File did not load properly. File Status: " + str(file_status))
	dialogue_file.close()
	
	# Parse the quest data and check for errors.
	var dialogue_result: Dictionary
	var dialogue_json_return: JSONParseResult = JSON.parse(quest_raw)
	assert(dialogue_json_return.error == OK, "Failed to parse dialogue JSON properly! See error below... \n" + str(dialogue_json_return.error))
	if dialogue_json_return.error == OK:
		dialogue_result = dialogue_json_return.result
		return dialogue_result["dialogue"]
	else:
		print("JSON did not parse properly. JSON Error: " + str(dialogue_json_return.error))
	return []
