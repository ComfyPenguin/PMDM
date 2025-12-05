class_name Player
extends CharacterBody2D

var movement_speed = 400.0
@onready var ball = get_tree().get_first_node_in_group("Ball")

func _physics_process(_delta: float) -> void:
	movement()
	

func movement():
	velocity = Vector2.ZERO
	
	if Input.is_action_pressed("Move_left"):
		velocity.x -= movement_speed
	if Input.is_action_pressed("Move_right"):
		velocity.x += movement_speed
	
	move_and_slide()
