# SpawnManager.gd
extends Node2D

@export var initial_speed: float = 300.0
@export var max_speed: float = 500.0
@export var acceleration: float = 5.0

var current_speed: float

func _ready() -> void:
	current_speed = initial_speed

func _process(delta: float) -> void:
	if current_speed < max_speed:
		current_speed += acceleration * delta
	
	for child in get_children():
		if child.has_method("set_speed"):
			child.set_speed(current_speed)
