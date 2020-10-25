extends KinematicBody2D

signal talks # When the player first tries to talk to an npc
signal progress_dialogue # When a player is talking and wants to progress through the dialogue

var is_talking: bool

export(int) var speed: int = 50
var direction: Vector2 = Vector2.ZERO

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		if not is_talking:
			emit_signal("talks")
		else:
			emit_signal("progress_dialogue")
	
	if direction == Vector2.ZERO and not is_talking:
		if Input.is_action_just_released("move_up"):
			$AnimatedSprite.animation = "idle_up"
		elif Input.is_action_just_released("move_down"):
			$AnimatedSprite.animation = "idle_down"
		elif Input.is_action_just_released("move_left"):
			$AnimatedSprite.animation = "idle_left"
		elif Input.is_action_just_released("move_right"):
			$AnimatedSprite.animation = "idle_right"
		elif (Input.is_action_pressed("move_up") and Input.is_action_pressed("move_down")
			or Input.is_action_pressed("move_left") and Input.is_action_pressed("move_right")):
			$AnimatedSprite.animation = "idle_down"
	
	if direction != Vector2.ZERO and not is_talking:
		if Input.is_action_pressed("move_up"):
			$AnimatedSprite.animation = "move_up"
		elif Input.is_action_pressed("move_down"):
			$AnimatedSprite.animation = "move_down"
		elif Input.is_action_pressed("move_left"):
			$AnimatedSprite.animation = "move_left"
		elif Input.is_action_pressed("move_right"):
			$AnimatedSprite.animation = "move_right"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	direction = Vector2.ZERO
	_get_input()
	var velocity: Vector2 = speed * direction.normalized()
	if not is_talking:
		move_and_slide(velocity)

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

func started_dialogue() -> void:
	is_talking = true

func finished_dialogue() -> void:
	is_talking = false
