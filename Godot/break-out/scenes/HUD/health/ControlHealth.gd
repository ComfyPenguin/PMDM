extends Control
# Mètode per actualitzar les vides
func draw_lives(lives: int):
	# Itera sobre els fills (els cors/vides)
	for i in range(get_child_count()):
		var heart = get_child(i)  # Obté cada cor
		if i < lives:
			heart.visible = true  # Mostra els cors dins del rang de vides
		else:
			heart.visible = false  # Oculta els cors restants
