# Gameplay.gd
extends Node2D

@onready var player_scene = preload("res://Player/Bettle.tscn")
@onready var spawn_manager_scene = preload("res://SpawnManager/SpawnManager.tscn")
@onready var hud = $HUD
@onready var pollen_bar = hud.get_node("PollenBar")

func _ready():
	var player = player_scene.instantiate()
	add_child(player)

	var viewport_size = get_viewport_rect().size
	player.global_position = Vector2(viewport_size.x / 2, viewport_size.y - 100)

	var spawn_manager = spawn_manager_scene.instantiate()
	add_child(spawn_manager)
	spawn_manager.position = Vector2(0, -100)

func increase_pollen(amount: int):
	pollen_bar.value = clamp(pollen_bar.value + amount, 0, pollen_bar.max_value)

func decrease_pollen(amount: int):
	pollen_bar.value = clamp(pollen_bar.value - amount, 0, pollen_bar.max_value)
