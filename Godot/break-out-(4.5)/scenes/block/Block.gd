extends CharacterBody2D

@onready var animations = $Sprite2D/AnimationPlayer

func _ready():
	self.add_to_group("bricks")


func destroy():
	# Reproducir la animación de rotur1.2a
	animations.play("break")
	

func break_animation_finished(anim_name: StringName) -> void:
	if anim_name == "break":
		queue_free()
