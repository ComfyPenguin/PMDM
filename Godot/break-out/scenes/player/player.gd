class_name Player
extends CharacterBody2D

var movement_speed = 400.0
@onready var sprite = $Sprite2D

func _physics_process(_delta: float) -> void:
	movement()


func movement():
	velocity = Vector2.ZERO
	
	# Dirección de movimiento mediante teclas assignadas(<- A / D ->)
	if Input.is_action_pressed("Move_left"):
		velocity.x -= movement_speed
	if Input.is_action_pressed("Move_right"):
		velocity.x += movement_speed
		
	# Cambiar de sprte si hay movimiento
	if velocity.x != 0:
		sprite.frame = 1
	else:
		sprite.frame = 0
	
	move_and_slide()
