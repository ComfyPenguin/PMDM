extends Node

var game_over = false
var current_level=0 # Nivell actual

# Definim les senyals
signal lives_changed(new_lives)
signal score_changed(new_score)

# Definim les vides i els setters
var lives: int = 3:
	set(value):
		lives = value
		emit_signal("lives_changed", lives)

# Definim la puntuacio i els setters
var score: int = 0:
	set(value):
		score = value
		emit_signal("score_changed", score)
