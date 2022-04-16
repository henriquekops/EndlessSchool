extends Area2D

export var speed = 400
var screen_size
var velocity

func _ready():
	screen_size = get_viewport_rect().size
	position = Vector2(screen_size.x/2, screen_size.y/2)

func _process(delta):
	velocity = Vector2.ZERO
	if Input.is_action_pressed("Move Up"):
		velocity.y -= 1
	if Input.is_action_pressed("Move Down"):
		velocity.y += 1
	if Input.is_action_pressed("Move Right"):
		velocity.x += 1
	if Input.is_action_pressed("Move Left"):
		velocity.x -= 1
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	
	position += velocity * delta
	position.x = clamp(position.x, 50, screen_size.x-50)
	position.y = clamp(position.y, 50, screen_size.y-50)
