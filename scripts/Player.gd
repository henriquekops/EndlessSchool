extends KinematicBody2D

class_name Player

export var speed: int = 400

var velocity: Vector2
var collision: KinematicCollision2D

onready var screen_size: Vector2 = get_viewport_rect().size
onready var timer: Timer = $Timer

func _ready() -> void:
	position = Vector2((screen_size.x/2) - ($Sprite.scale.x*2), screen_size.y/2)
	timer.connect("timeout", self, "_on_Timer_timeout")

func _physics_process(delta: float) -> void:
	velocity = move().normalized() * speed * delta
	position.x = clamp(position.x, 50, screen_size.x-50)
	position.y = clamp(position.y, 50, screen_size.y-50)
	collision = move_and_collide(velocity)
	if collision != null:
		if collision.collider.name == "Enemy":
			call_deferred("free")

func _on_Item_body_entered(body: Node2D):
	speed = speed * 2
	timer.start(5)

func _on_Timer_timeout():
	speed = speed / 2
	timer.stop()

func move() -> Vector2:
	velocity = Vector2.ZERO
	if Input.is_action_pressed("Move Up"):
		velocity.y -= 1
	if Input.is_action_pressed("Move Down"):
		velocity.y += 1
	if Input.is_action_pressed("Move Right"):
		velocity.x += 1
	if Input.is_action_pressed("Move Left"):
		velocity.x -= 1
	return velocity
