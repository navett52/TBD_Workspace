class_name Player extends CharacterBody2D

signal interacts # When the player first tries to talk to an npc
signal progress_dialogue # When a player is talking and wants to progress through the dialogue

@onready var interactable: Interactable = $Interactable

@export var speed: int = 50
var direction: Vector2 = Vector2.ZERO
var tool_equipped: int = G.Items.NONE

func _process(delta: float) -> void:
	if interactable.is_interacting:
		# process dialog
		if Input.is_action_just_pressed("ui_accept"):
			emit_signal("progress_interaction")
	else:
		_process_movement()
	
	# check if should be in dialog
	if Input.is_action_just_pressed("ui_accept"):
		if interactable.in_interact_range and not interactable.is_interacting:
			var can_interact = interactable.interactee.interact(tool_equipped)
			if can_interact:
				start_interacting()
	
	####
	
	
#	if Input.is_action_pressed("ui_inventory"):
#		$UI/Inventory.visible = true
#	else:
#		$UI/Inventory.visible = false

func _process_movement():
	var anim_name: String = $AnimatedSprite2D.animation
	if direction == Vector2.ZERO and not anim_name.begins_with("idle"):
		if Input.is_action_just_released("move_up"):
			$AnimatedSprite2D.play("idle_up")
		elif Input.is_action_just_released("move_down"):
			$AnimatedSprite2D.play("idle_down")
		elif Input.is_action_just_released("move_left"):
			$AnimatedSprite2D.play("idle_left")
		elif Input.is_action_just_released("move_right"):
			$AnimatedSprite2D.play("idle_right")
		elif (Input.is_action_pressed("move_up") and Input.is_action_pressed("move_down")
			or Input.is_action_pressed("move_left") and Input.is_action_pressed("move_right")):
			$AnimatedSprite2D.play("idle_down")
	
	if direction != Vector2.ZERO and not anim_name.begins_with("move"):
		if Input.is_action_pressed("move_up"):
			$AnimatedSprite2D.play("move_up")
		elif Input.is_action_pressed("move_down"):
			$AnimatedSprite2D.play("move_down")
		elif Input.is_action_pressed("move_left"):
			$AnimatedSprite2D.play("move_left")
		elif Input.is_action_pressed("move_right"):
			$AnimatedSprite2D.play("move_right")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	direction = Vector2.ZERO
	_get_input()
	var velocity: Vector2 = speed * direction.normalized()
	if not interactable.is_interacting:
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

func give(item: int) -> void:
	assign_inventory(item)

func assign_inventory(item: int) -> void:
	var inventory_slots: Array = get_node("UI/Inventory/Container").get_children()
	for slot in inventory_slots:
		if slot.assigned_tool == G.Items.NONE:
			slot.assigned_tool = item
			break

# should probably move the below to the Interactable component
func _on_InteractArea_area_entered(area: Area2D) -> void:
	interactable.interactee = area.get_parent()
	if interactable.interactee.has_method("interact"):
		interactable.in_interact_range = true

func _on_InteractArea_area_exited(area: Area2D) -> void:
	interactable.interactee = area.get_parent()
	if interactable.interactee.has_method("interact"):
		interactable.in_interact_range = false

func start_interacting() -> void:
	interactable.is_interacting = true
	emit_signal("talks")

func stop_interacting() -> void:
	interactable.is_interacting = false
