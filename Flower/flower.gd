# Flower.gd
extends Node2D

enum FlowerType { MALE, FEMALE, FEMALE_POLLINATED }

@export var flower_type: FlowerType = FlowerType.MALE
@export var speed: float = 100.0

@onready var sprite = $Sprite
@onready var detector = $Area2D

signal pollen_collected(amount: int)
signal pollen_used(amount: int)

var gameplay: Node = null

func _ready() -> void:
	update_visual()

func _process(delta: float) -> void:
	position.y += speed * delta
	if position.y > get_viewport_rect().size.y + 150:
		queue_free()


func update_visual() -> void:
	match flower_type:
		FlowerType.MALE:
			sprite.texture = preload("res://Assets/Sprites/flower_male.png")
		FlowerType.FEMALE:
			sprite.texture = preload("res://Assets/Sprites/flower_female.png")
		FlowerType.FEMALE_POLLINATED:
			sprite.texture = preload("res://Assets/Sprites/flower_female_pollinated.png")


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name != "Player":
		return

	match flower_type:
		FlowerType.MALE:
			emit_signal("pollen_collected", 20)

		FlowerType.FEMALE:
			if gameplay.pollen_bar.value >= 10:
				emit_signal("pollen_used", 10)
				flower_type = FlowerType.FEMALE_POLLINATED
				update_visual()
				detector.set_deferred("monitoring", false)
