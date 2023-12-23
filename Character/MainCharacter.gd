extends CharacterBody2D
class_name Player

signal talks # When the player first tries to talk to an npc
signal progress_dialogue # When a player is talking and wants to progress through the dialogue

var is_talking: bool

var in_interact_range: bool = false
var interactee: Node

@export var speed: int = 50
var direction: Vector2 = Vector2.ZERO

var tool_equipped: int = G.Items.NONE

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		# Dialogue system control
		if not is_talking:
			emit_signal("talks")
		else:
			emit_signal("progress_dialogue")
		
		# Contextual interaction control
		if in_interact_range:
			interactee.interact(tool_equipped)
	
#	if Input.is_action_pressed("ui_inventory"):
#		$UI/Inventory.visible = true
#	else:
#		$UI/Inventory.visible = false
	
	if direction == Vector2.ZERO and not is_talking:
		if Input.is_action_just_released("move_up"):
			$AnimatedSprite2D.animation = "idle_up"
		elif Input.is_action_just_released("move_down"):
			$AnimatedSprite2D.animation = "idle_down"
		elif Input.is_action_just_released("move_left"):
			$AnimatedSprite2D.animation = "idle_left"
		elif Input.is_action_just_released("move_right"):
			$AnimatedSprite2D.animation = "idle_right"
		elif (Input.is_action_pressed("move_up") and Input.is_action_pressed("move_down")
			or Input.is_action_pressed("move_left") and Input.is_action_pressed("move_right")):
			$AnimatedSprite2D.animation = "idle_down"
	
	if direction != Vector2.ZERO and not is_talking:
		if Input.is_action_pressed("move_up"):
			$AnimatedSprite2D.animation = "move_up"
		elif Input.is_action_pressed("move_down"):
			$AnimatedSprite2D.animation = "move_down"
		elif Input.is_action_pressed("move_left"):
			$AnimatedSprite2D.animation = "move_left"
		elif Input.is_action_pressed("move_right"):
			$AnimatedSprite2D.animation = "move_right"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	direction = Vector2.ZERO
	_get_input()
	var velocity: Vector2 = speed * direction.normalized()
	if not is_talking:
		set_velocity(velocity)
		move_and_slide()

func _get_input() -> void:
	# Create the direction vector based on what buttons are pressed.
	if Input.is_action_pressed("move_up"):
		direction.y += -1
	if Input.is_action_pressed("move_down"):
		direction.y += 1
	if Input.is_action_pressed("move_left"):
		direction.x += -1
	if Input.is_action_pressed("move_right"):
		direction.x += 1

#func give(item: int) -> void:
#	assign_inventory(item)
#
#func assign_inventory(item: int) -> void:
#	var inventory_slots: Array = get_node("UI/Inventory/Container").get_children()
#	for slot in inventory_slots:
#		if slot.assigned_tool == G.Items.NONE:
#			slot.assigned_tool = item
#			break
#
#func _on_InteractArea_area_entered(area: Area2D) -> void:
#	interactee = area.get_parent()
#	if interactee.has_method("interact"):
#		in_interact_range = true
#
#func _on_InteractArea_area_exited(area: Area2D) -> void:
#	interactee = area.get_parent()
#	if interactee.has_method("interact"):
#		in_interact_range = false
#
func started_dialogue() -> void:
	is_talking = true

func finished_dialogue() -> void:
	is_talking = false
