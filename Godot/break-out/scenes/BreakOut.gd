extends Node2D

var center


func _ready() -> void:
	var viewport_size=get_viewport().size
	center = Vector2(viewport_size.x/2, viewport_size.y/2)
	
	# Inicializar la bola sobre el jugador
	$Ball.reset_ball($Player)

# Señal que detecta cuando termina el Timer
func _on_reset_timer_timeout():
	$Ball.visible = true
	#$Ball.call("set_ball_velocity")
	# Reset de la posicion del jugador y de la bola
	$Player.position.x = center.x
	$Ball.reset_ball($Player)

# Si entra en el limite del juego, hara invisible la bola e inicia el Timer de 1s
func _on_area_2d_game_limit_body_entered(body: Node2D) -> void:
	if body.name != "Ball": return
	
	GameData.lives -= 1
	# Gestionem el final del joc
	if(GameData.lives<=0):
		$HUD/GameOverLabel.visible=true
		$HUD/Button.visible=true
		GameData.game_over=true

	$Ball.visible = false
	$Reset_Timer.start()
	
