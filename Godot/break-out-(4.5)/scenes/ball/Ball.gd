extends CharacterBody2D

@export var speed = 500.0
var on_player = false  # Estat inicial de la pilota
var player             # Referència al player

func _physics_process(delta):
  # Solo movemos la pelota si es visible (self es la propia pelota)
	if not self.visible:
		return
		
	# Desplazamiento de la pelota, detectando colisiones
	var info_colission = move_and_collide(velocity * delta)

	# Si hay alguna colisión, calculamos el rebote (bounce)
	if info_colission:
		velocity = velocity.bounce(info_colission.get_normal())

		# Nuevo: Con get_collider sabemos el Background1objeto con el que hemos colisionado
		var collided_object = info_colission.get_collider()

		# Comprobamos si el objeto con el que ha colisionado es un brick
		# Si es así, le enviaremos la señal `destroy` (en realidad, invocaremos este método que hemos creado)
		if ("bricks" in collided_object.get_groups()):
			collided_object.destroy()
	
	# Comprobación de si la pelota está encima del jugador
	ball_on_player()

func _input(_event):
	if Input.is_action_pressed("throw_ball") and on_player:
		on_player = false
		velocity = Vector2(player.velocity.normalized().x, -1).normalized() * (speed * 1.5)  # Llança cap amunt


func reset_ball(node_player):
	player = node_player  # Assigna la referència
	on_player=true
	velocity = Vector2.ZERO  # Atura qualsevol moviment
	ball_on_player() # Ajust vertical perquè estiga damunt

func ball_on_player():
	if on_player and player:
		position = player.global_position + Vector2(0, -25)


# func _ready():
# 	set_ball_velocity()


#func set_ball_velocity():
	#if randi() % 2 == 0:
		#velocity.x = 1
	#else:
		#velocity.x = -1
	#if randi() % 2 == 0:
		#velocity.y = 1
	#else:
		#velocity.y = -1
#
	#velocity *= speed
