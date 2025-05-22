# FlowerSpawner.gd
extends Node2D

@export var flower_scene: PackedScene
@export var spawn_interval := 1.5
@export var spawn_probability := 0.8  # 80% chance de gerar uma flor

var time := 0.0
var flower_speed: float = 100.0

func _process(delta):
	time += delta
	if time >= spawn_interval:
		time = 0.0
		if randf() <= spawn_probability:
			spawn_flower()
			
func set_speed(value: float) -> void:
	flower_speed = value

func spawn_flower():
	var flower_instance = flower_scene.instantiate()
	
	# Sorteia macho ou fêmea
	var flower_type = randi() % 2
	flower_instance.flower_type = flower_type

	# Posiciona fora do topo da tela
	var viewport_width = get_viewport_rect().size.x
	var random_x = randf_range(50, viewport_width - 50)
	flower_instance.position = Vector2(random_x, -50)

	# Conecta os sinais ao Gameplay (HUD)
	var gameplay = get_tree().current_scene
	if gameplay:
		flower_instance.gameplay = gameplay
		flower_instance.connect("pollen_collected", Callable(gameplay, "increase_pollen"))
		flower_instance.connect("pollen_used", Callable(gameplay, "decrease_pollen"))

	flower_instance.speed = flower_speed  # aplica velocidade atual
	flower_instance.z_index = 1
	
	add_child(flower_instance)
