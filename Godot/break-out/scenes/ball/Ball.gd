extends CharacterBody2D

@export var speed = 500.0
var on_player = false # Estat inicial de la pilota
var player # Referència al player

# Variables per gestionar el swipe
var swiping = false # Si estem arrossegant
var swipe_start = Vector2.ZERO # Punt d’inici de l’arrossegament
var swipe_end = Vector2.ZERO # Punt final de l’arrossegament
var swipe_start_time = 0.0 # Temps d'inici de l'arrossegament


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


func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.is_pressed():
				swiping = true
				swipe_start = event.position
				swipe_end = event.position
				swipe_start_time = Time.get_ticks_msec() / 1000.0
			else:
				if swiping:
					swiping = false
					swipe_end = event.position
					var swipe_duration = Time.get_ticks_msec() / 1000.0 - swipe_start_time # Duració del drag
					if swipe_duration > 0.0 and swipe_duration < 0.5 and swipe_start != swipe_end:
						_throw_ball(swipe_start, swipe_end, swipe_duration)

	elif event is InputEventScreenTouch:
		if event.is_pressed():
			swiping = true
			swipe_start = event.position
			swipe_end = event.position
			swipe_start_time = Time.get_ticks_msec() / 1000.0
		else:
			if swiping:
				swiping = false
				var swipe_duration = Time.get_ticks_msec() / 1000.0 - swipe_start_time # Duració del drag
				if swipe_duration > 0.0 and swipe_duration < 0.5 and swipe_start != swipe_end:
					_throw_ball(swipe_start, swipe_end, swipe_duration)

	elif event is InputEventMouseMotion and swiping:
		swipe_end = event.position

	elif event is InputEventScreenDrag and swiping:
		swipe_end = event.position

	# Si s'esta fent us de l'espai per llançar la pilota,
	# Comprovem si esta sobre el jugador, que no s'esta arrossegant el dit,
	# i que la pilota esta en joc, i llancem aquesta.
	# Com que els parametres ara son diferents, necessitarem altra funcio _throw_ball_keyboard
	if Input.is_action_just_pressed("throw_ball") and on_player and not swiping and not GameData.game_over:
		_throw_ball_keyboard()


# Funcio per llançar la pilota
func _throw_ball(start, end, duration):
	# Només llancem si no és game over i està sobre el jugador
	if GameData.game_over or not on_player:
		return

	# Calcula la direcció de l’arrossegament
	var direction = (end - start).normalized()

	# Calcula la velocitat de la pilota en funció de la velocitat de l’arrossegament
	# Recordeu: velocitat=espai/temps
	# Calcularem la velocitat com el minim entre aquest valor calculat i 800, per limitar aquesta
	var launch_speed = min((end - start).length() / duration, 800)

	# Assigna la velocitat i llança la pilota
	on_player = false # La pilota ja no esta sobre el jugador
	velocity = direction * launch_speed


func _throw_ball_keyboard():
	# Llança la pilota amb la velocitat predeterminada
	on_player = false
	velocity = Vector2(player.velocity.normalized().x, -1).normalized() * 400 # Llança cap amunt


func reset_ball(node_player):
	player = node_player # Assigna la referència
	on_player = true
	velocity = Vector2.ZERO # Atura qualsevol moviment
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
