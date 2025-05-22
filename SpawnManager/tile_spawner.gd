# TileSpawner.gd
extends Node2D

@export var tile_scenes: Array[PackedScene]
@export var tile_speed := 100.0
@export var tile_interval := 3.0

var tile_timer := 0.0
var active_tiles: Array[Node2D] = []

func _ready():
	call_deferred("spawn_tile")  # Garante que viewport está pronto

func _process(delta: float) -> void:
	tile_timer += delta
	if tile_timer >= tile_interval:
		tile_timer = 0
		spawn_tile()

	# Move e remove tiles
	for tile in active_tiles:
		tile.position.y += tile_speed * delta

	if active_tiles.size() > 0:
		var first_tile = active_tiles[0]
		if first_tile.position.y > get_viewport().size.y * 1.5:
			first_tile.queue_free()
			active_tiles.remove_at(0)

func set_speed(value: float) -> void:
	tile_speed = value

func spawn_tile():
	if tile_scenes.is_empty():
		return

	var index = randi() % tile_scenes.size()
	var tile = tile_scenes[index].instantiate()

	var y_pos := 0.0

	var viewport_width = get_viewport().get_visible_rect().size.x
	var sprite = tile.get_node("Sprite2D")
	var texture_width = sprite.texture.get_width()
	
	tile.position = Vector2((viewport_width - texture_width) / 2, y_pos)
	tile.z_index = 0
	
	add_child(tile)
	active_tiles.append(tile)
