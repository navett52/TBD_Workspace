extends Sprite2D
class_name NPC

@export var dialogue_path: String
@export var objective: String
@export var reward: int # (int, "None", "Lantern")

var should_talk: bool = false
var talking: bool = false
var dialogue_box: Dialogue

@onready var player: Node = get_parent().get_node("Main Character")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Connect to the talks signal from the player
	player.connect("talks", Callable(self, "initiate_dialogue"))

func initiate_dialogue() -> void:
	if should_talk:
		# Create a new instance of dialogue box and setup it's connections with the player.
		dialogue_box = G.dialogue_scene.instantiate()
		dialogue_box.dialogue_path = self.dialogue_path
		player.connect("progress_dialogue", Callable(dialogue_box, "progress_dialogue"))
		dialogue_box.connect("started_dialogue", Callable(player, "started_dialogue"))
		dialogue_box.connect("finished_dialogue", Callable(player, "finished_dialogue"))
		dialogue_box.connect("finished_dialogue", Callable(self, "finished_dialogue"))
		player.get_node("UI").add_child(dialogue_box)

func finished_dialogue() -> void:
	# This is broken because you got caught in a rabbit hole and changed the json file of the dialogue...
	match(player.objectives[objective]):
		player.quest_states.UNACCEPTED:
			player.objectives[objective] = player.quest_states.ACCEPTED
		player.quest_states.COMPLETE:
			player.give(reward)

# Set whether the player is within range to start dialogue.
func _on_TalkArea_body_entered(body: Node) -> void:
	if body.name == "Main Character":
		should_talk = true

func _on_TalkArea_body_exited(body: Node) -> void:
	if body.name == "Main Character":
		should_talk = false
