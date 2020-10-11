extends KinematicBody2D

signal talks
var talking

export(int) var speed = 50
var velocity = Vector2.ZERO
var look_direction = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		emit_signal("talks")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var direction = Vector2.ZERO
	
	# Construct the vector that represents direction of sprite.
	if Input.is_action_pressed("move_up"):
		direction.y = -1
		look_direction = Vector2(0, -1)
	if Input.is_action_pressed("move_down"):
		direction.y = 1
		look_direction = Vector2(0, 1)
	if Input.is_action_pressed("move_left"):
		direction.x = -1
		look_direction = Vector2(-1, 0)
	if Input.is_action_pressed("move_right"):
		direction.x = 1
		look_direction = Vector2(1, 0)
	
	velocity = speed * direction
	
	if not talking:
		move_and_slide(velocity)
