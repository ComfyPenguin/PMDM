extends CanvasLayer

func _ready():
	# En iniciar l'script, connectem aquest per a que escolte les senyals
	GameData.connect("lives_changed", Callable(self, "_on_lives_changed"))
	GameData.connect("score_changed", Callable(self, "_on_score_changed"))
	$Button.connect("pressed", Callable(self, "_on_Button_pressed"))

	# Sincronitzem la UI amb les dades persistides en carregar una nova escena
	_on_lives_changed(GameData.lives)
	_on_score_changed(GameData.score)
	$GameOverLabel.visible = GameData.game_over
	$Button.visible = GameData.game_over
	
func _on_lives_changed(lives):
	# Quan es modifica el nombre de vides, repintem les vides restants
	# Ho farem a un nou Script associat al node *ControlVides* que tenim creat.
	$ControlHealth.draw_lives(lives)

func _on_score_changed(new_score):
	# Quan es modifique la puntuació, actualitzarem aquesta a la UI
	$ScoreLabel.text = str(new_score)

func _on_Button_pressed():
	GameData.score=0
	GameData.lives=3
	GameData.game_over=false
	$GameOverLabel.visible=false
	$Button.visible=false

	get_tree().change_scene_to_file("res://scenes/BreakOut.tscn")
