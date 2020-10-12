extends KinematicBody2D

export(int) var speed = 50
var direction = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	if direction == Vector2.ZERO:
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
	
	if direction != Vector2.ZERO:
		if Input.is_action_pressed("move_up"):
			$AnimatedSprite.animation = "move_up"
		elif Input.is_action_pressed("move_down"):
			$AnimatedSprite.animation = "move_down"
		elif Input.is_action_pressed("move_left"):
			$AnimatedSprite.animation = "move_left"
		elif Input.is_action_pressed("move_right"):
			$AnimatedSprite.animation = "move_right"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	direction = Vector2.ZERO
	get_input()
	var velocity = speed * direction.normalized()
	move_and_slide(velocity)

func get_input():
	# Create the direction vector based on what buttons are pressed.
	if Input.is_action_pressed("move_up"):
		direction.y += -1
	if Input.is_action_pressed("move_down"):
		direction.y += 1
	if Input.is_action_pressed("move_left"):
		direction.x += -1
	if Input.is_action_pressed("move_right"):
		direction.x += 1
