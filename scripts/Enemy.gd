extends KinematicBody2D

class_name Enemy

export var speed: int = 150
export var fov_distance: int = 400
export var fov_angle: float = deg2rad(360)
export var fov_inner_angle: float = deg2rad(10)

var velocity: Vector2
var target: Vector2

onready var raycast: RayCast2D = $RayCast2D
onready var screen_size: Vector2 = get_viewport().size
onready var raycast_coordinates: Array = raycast_coordinates()

onready var animatedSprite: AnimatedSprite = $AnimatedSprite;

func verificaAnimacao(player):
	var vertical = 0;
	var horizontal = 0;
	if player.position.y > position.y:
		vertical = 1;
	else:
		vertical = -1;
		
	if player.position.x > position.x:
		horizontal = 1;
	else:
		horizontal = -1;
	
	var animacaoAtual = "down";
	if vertical == -1:
		animacaoAtual = "up";
	elif horizontal == 1:
		animacaoAtual = "right";
	elif vertical == 1:
		animacaoAtual = "down";
	else:
		animacaoAtual = "left";
	animatedSprite.play(animacaoAtual);
	pass



func _physics_process(delta: float) -> void:
	for ray_coordinate in raycast_coordinates():
		raycast.cast_to = ray_coordinate
		raycast.force_raycast_update()
		if raycast.is_colliding() and raycast.get_collider() is Player:
			
			verificaAnimacao( raycast.get_collider());
			
			target = raycast.get_collision_point()
			var dir = (target - global_position).normalized()
			position.x = clamp(position.x, 50, screen_size.x-50)
			position.y = clamp(position.y, 50+90, screen_size.y-50)
			move_and_collide(dir * speed * delta)
			break

func raycast_coordinates() -> Array:
	var raycast_coordinates: Array = []
	var ray_count = int(fov_angle / fov_inner_angle) + 1
	for index in ray_count:
		var coordinates: Vector2 = (
			fov_distance 
			* Vector2.UP.rotated(fov_inner_angle * (index - ray_count / 2.0))
		)
		raycast_coordinates.append(coordinates)
	return raycast_coordinates
