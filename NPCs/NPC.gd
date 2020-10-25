extends Sprite

export(String) var dialogue_path: String

var should_talk: bool = false
var talking: bool = false
var dialogue_box: Dialogue

onready var player: Node = get_parent().get_node("Main Character")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Connect to the talks signal from the player
	player.connect("talks", self, "initiate_dialogue")

func initiate_dialogue() -> void:
	if should_talk:
		print("Oh! He spoke to me... I should say something back.")
		dialogue_box = G.dialogue_scene.instance()
		dialogue_box.dialogue_path = self.dialogue_path
		player.connect("progress_dialogue", dialogue_box, "progress_dialogue")
		dialogue_box.connect("started_dialogue", player, "started_dialogue")
		dialogue_box.connect("finished_dialogue", player, "finished_dialogue")
		player.get_node("UI").add_child(dialogue_box)

# Set whether the player is within range to start dialogue.
func _on_TalkArea_body_entered(body: Node) -> void:
	if body.name == "Main Character":
		print("Player got close to me, maybe I should say something")
		should_talk = true

func _on_TalkArea_body_exited(body: Node) -> void:
	if body.name == "Main Character":
		print("Nevermind he left...")
		should_talk = false
