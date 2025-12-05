extends CharacterBody2D

var speed = 300.0

func _physics_process(delta: float) -> void:
	if not self.visible:
		return
	
	var info_collision = move_and_collide(velocity * delta)
	if info_collision:
		velocity = velocity.bounce(info_collision.get_normal())

func _ready():
	set_ball_velocity()

func set_ball_velocity():
	if randi() % 2 == 0:
		velocity.x = 1
	else:
		velocity.x = -1
	if randi() % 2 == 0:
		velocity.y = 1
	else:
		velocity.y = -1

	velocity *= speed
