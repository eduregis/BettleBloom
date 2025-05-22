# EnemySpawner.gd
extends Node2D

@export var fly_scene: PackedScene
@export var dragonfly_scene: PackedScene
@export var spawn_interval: float = 2.5

var timer := 0.0
var enemy_speed: float = 100.0

func set_speed(value: float) -> void:
	enemy_speed = value

func _process(delta: float) -> void:
	timer += delta
	if timer >= spawn_interval:
		timer = 0
		spawn_enemy()

func spawn_enemy():
	var viewport_width = get_viewport_rect().size.x
	var random_x = randf_range(50, viewport_width - 50)

	var enemy_type = randi() % 2
	var enemy

	match enemy_type:
		0:
			enemy = fly_scene.instantiate()
		1:
			enemy = dragonfly_scene.instantiate()

	enemy.position = Vector2(random_x, -50)
	enemy.speed = enemy_speed
	enemy.z_index = 2 
	
	add_child(enemy)
