class_name Player
extends CharacterBody2D

var movement_speed = 400.0
@onready var sprite = $Sprite2D
# Touch ratón
var touch_x = null 

func _physics_process(_delta: float) -> void:
	movement_touch(_delta)

func _input(event):
	# Detectem si s'esta produint un tap o un clic en la pantalla
	if event is InputEventMouseButton:
		# print("S'ha detectat un event tap/click")
		# Comprovem si es tracta d'un clic o touch (inicial) en la pantalla
		if event.is_pressed():
			#print("El tap o clic es mante")
			# Si es aixi, ens guardem la posicio x d'on s'ha produit el toc
			touch_x = event.position.x  # Guarda la posició X del toc
		else:
			# print("El tap o clic s'ha alliberat")
			touch_x = null  # Reseteja si es deixa de tocar

	# Si s'esta movent el ratoli o el dit per la pantalla, actualitzem la posicio X
	elif event is InputEventMouseMotion and touch_x != null:
		touch_x = event.position.x  # Actualitza la posició X del toc

func movement():
	# No ens movem si el joc ha acabat
	if GameData.game_over:
		return
		
	velocity = Vector2.ZERO

	# Dirección de movimiento mediante teclas assignadas
	if Input.is_action_pressed("Move_left"):
		velocity.x -= movement_speed
	if Input.is_action_pressed("Move_right"):
		velocity.x += movement_speed
		
	# Cambiar de sprite si hay movimiento
	if velocity.x != 0:
		sprite.frame = 1
	else:
		sprite.frame = 0
		
	move_and_slide()


func movement_touch(delta):
	# No ens movem si el joc ha acabat
	if GameData.game_over:
		return

	velocity = Vector2.ZERO

	# Comprovem si la posicio touch_x no es nul·la, 
	# per vore si s'esta movent el jugador amb la 
	# pantalla tactil o el ratoli
	if touch_x != null:
		#  Si es aixi, movem el jugador cap a la posicio touch_x
		velocity.x = (touch_x - global_position.x) * movement_speed * delta
	else:
		# Si no s'esta utilitzant la pantalla tactil, comprovem el gamepad/teclat
		var input_axis = Input.get_action_strength("Move_right") - Input.get_action_strength("Move_left")
		velocity.x = input_axis * movement_speed

	# Cambiar de sprite si hay movimiento
	if velocity.x != 0:
		sprite.frame = 1
	else:
		sprite.frame = 0

	# Movem el jugador
	move_and_collide(velocity * delta)
