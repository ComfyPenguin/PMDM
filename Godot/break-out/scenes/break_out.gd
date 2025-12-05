extends Node2D

var center


func _ready() -> void:
	var viewport_size=get_viewport().size
	center = Vector2(viewport_size.x/2, viewport_size.y/2)
	$Reset_Timer.timeout.connect(_on_reset_timer_timeout)
	


func reset():
	if $Ball.visible:
		$Ball.position = center
		$Player.position.x = center.x
		$Ball.visible = false
		$Reset_Timer.start()


func _on_reset_timer_timeout():
	$Ball.visible = true
	$Ball.call("set_ball_velocity")


func _on_area_2d_game_limit_body_entered(body: Node2D) -> void:
	if body.name != "Ball": return
	reset()
	
