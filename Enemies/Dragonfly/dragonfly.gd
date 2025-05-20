# Dragonfly.gd
extends Node2D

@export var speed: float = 100.0
@export var move_range: float = 100.0
@onready var start_x = position.x
var direction = 1

func _process(delta: float) -> void:
	position.y += speed * delta
	position.x += direction * 100 * delta
	
	if abs(position.x - start_x) > move_range:
		direction *= -1
	
	if position.y > get_viewport_rect().size.y + 50:
		queue_free()
