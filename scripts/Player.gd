extends KinematicBody2D

class_name Player

export (int) var speed = 400
var screen_size: Vector2
var velocity: Vector2
var timer: Timer

func _ready():
	screen_size = get_viewport_rect().size
	position = Vector2($Sprite.scale.x/2, $Sprite.scale.y/2)
	timer = $Timer
	timer.connect("timeout", self, "_on_Timer_timeout")

func _physics_process(delta):
	velocity = Vector2.ZERO
	if Input.is_action_pressed("Move Up"):
		velocity.y -= 1
	if Input.is_action_pressed("Move Down"):
		velocity.y += 1
	if Input.is_action_pressed("Move Right"):
		velocity.x += 1
	if Input.is_action_pressed("Move Left"):
		velocity.x -= 1
	
	#if velocity.length() > 0:
	velocity = velocity.normalized() * speed * delta
	position.x = clamp(position.x, 50, screen_size.x-50)
	position.y = clamp(position.y, 50, screen_size.y-50)

	move_and_collide(velocity)

func _on_Item_body_entered(body):
	speed = speed * 2
	timer.start(5)

func _on_Timer_timeout():
	speed = speed / 2
	timer.stop()
