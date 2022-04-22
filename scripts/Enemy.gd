extends KinematicBody2D

class_name Enemy

export var speed: int = 50
export var fov_distance: int = 400
export var fov_angle: float = deg2rad(360.0)
export var fov_inner_angle: float = deg2rad(10.0)

var screen_size: Vector2
var velocity: Vector2
var target: Vector2

func generate_raycasts() -> void:
	var ray_count = fov_angle / fov_inner_angle
	for index in ray_count:
		var ray = RayCast2D.new()
		var angle = fov_inner_angle * (index - ray_count / 2.0)
		ray.cast_to = Vector2.UP.rotated(angle) * fov_distance
		ray.enabled = true
		add_child(ray)

func _ready() -> void:
	screen_size = get_viewport_rect().size
	position = Vector2((screen_size.x/2) + ($Sprite.scale.x*2), screen_size.y/2)
	generate_raycasts()

func _physics_process(delta: float) -> void:
	for ray in get_children().slice(2, -1):
		if ray.is_colliding() and ray.get_collider() is Player:
			target = ray.get_collision_point()
			var dir = (target - global_position).normalized()
			move_and_collide(dir * speed * delta)
