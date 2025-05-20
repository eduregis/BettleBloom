# Fly.gd
extends Node2D

@export var speed: float = 100.0

func _process(delta: float) -> void:
	position.y += speed * delta
	if position.y > get_viewport_rect().size.y + 50:
		queue_free()
