extends Sprite

onready var player = get_parent().get_node("Main Character")

var quest_path = "res://NPCs/test_script.json"
var quest_result

var quest_dialogue
var should_talk = false
var talking = false
var total_dialogue_count
var current_dialogue = 0
var text_box

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
	total_dialogue_count = quest_dialogue.size()
	
	# Connect to the talks signal from the player
	player.connect("talks", self, "initiate_dialogue")

func initiate_dialogue():
	print("Initiating dialogue")
	text_box = get_node_or_null("Dialogue Box")
	if current_dialogue < total_dialogue_count and talking:
		text_box.text = quest_dialogue[current_dialogue]
		current_dialogue += 1
	elif text_box:
		talking = false
		should_talk = false
		player.talking = false
		current_dialogue = 0
		self.remove_child(text_box)
		text_box.queue_free()
	
	if should_talk and not talking:
		talking = true
		player.talking = true
		text_box = RichTextLabel.new()
		text_box.name = "Dialogue Box"
		text_box.text = quest_dialogue[current_dialogue]
		current_dialogue += 1
		text_box.rect_size = Vector2(448, 96)
		text_box.anchor_left = .10
		text_box.anchor_right = .90
		self.add_child(text_box)

# Set whether the player is within range to start dialogue.
func _on_TalkArea_body_entered(body):
	if body.name == "Main Character":
		should_talk = true
func _on_TalkArea_body_exited(body):
	if body.name == "Main Character":
		should_talk = false
