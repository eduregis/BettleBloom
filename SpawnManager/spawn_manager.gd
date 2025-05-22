# SpawnSpawner.gd
extends Node2D

@export var base_speed: float = 200.0
@export var speed_increase_rate: float = 2.0  # aumento por segundo
@export var max_speed: float = 400.0 

var current_speed: float = 100.0

@onready var flower_spawner = $FlowerSpawner
@onready var enemy_spawner = $EnemySpawner
@onready var tile_spawner = $TileSpawner

func _process(delta: float) -> void:
	current_speed = min(current_speed + speed_increase_rate * delta, max_speed)
	update_spawner_speeds()

func update_spawner_speeds():
	if flower_spawner:
		flower_spawner.set_speed(current_speed)

	if enemy_spawner:
		enemy_spawner.set_speed(current_speed)
		
	if tile_spawner:
		tile_spawner.set_speed(current_speed)
