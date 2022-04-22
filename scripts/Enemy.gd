extends KinematicBody2D

class_name Enemy

export var speed: int = 100
export var fov_distance: int = 400
export var fov_angle: float = deg2rad(360)
export var fov_inner_angle: float = deg2rad(36)

var velocity: Vector2
var target: Vector2

onready var raycast: RayCast2D = $RayCast2D
onready var screen_size: Vector2 = get_viewport().size
onready var raycast_coordinates: Array = raycast_coordinates()

func _ready() -> void:
	position = Vector2((screen_size.x/2) + ($Sprite.scale.x*2), screen_size.y/2)

func _physics_process(delta: float) -> void:
	for ray_coordinate in raycast_coordinates():
		raycast.cast_to = ray_coordinate
		raycast.force_raycast_update()
		if raycast.is_colliding() and raycast.get_collider() is Player:
			target = raycast.get_collision_point()
			break
	var dir = (target - global_position).normalized()
	move_and_collide(dir * speed * delta)

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
