# Bettle.gd
extends CharacterBody2D

var speed = 400
var acceleration = 20
var friction = 25

func _physics_process(delta):
	var input_dir = Input.get_axis("move_left", "move_right")
	
	var target_velocity = Vector2(input_dir * speed, 0)
	
	velocity.x = lerp(velocity.x, target_velocity.x, acceleration * delta)
	
	if input_dir == 0:
		velocity.x = move_toward(velocity.x, 0, friction * delta)
	
	move_and_slide()
	
	global_position.x = clamp(global_position.x, 50, get_viewport_rect().size.x - 50)
