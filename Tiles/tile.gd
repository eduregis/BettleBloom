# Tile.gd
extends Node2D
@export var speed: float = 100.0

func _process(delta):
	position.y += speed * delta
