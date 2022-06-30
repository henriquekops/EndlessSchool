extends Area2D

class_name Projectile

enum Direction {UP, DOWN, LEFT, RIGHT}

export var speed = 700;

var deltaspeed = PlayerSingleton.shootrange;

onready var direction: int =  Direction.UP	
	
func _process(delta):
	var degrees_per_second = 360.0
	$Sprite.rotate(delta * deg2rad(degrees_per_second))

func _physics_process(delta):
	match direction:
		Direction.UP:
			position -= transform.y * speed * delta * deltaspeed
		Direction.DOWN:
			position += transform.y * speed * delta * deltaspeed
		Direction.LEFT:
			position -= transform.x * speed * delta * deltaspeed
		Direction.RIGHT:
			position += transform.x * speed * delta * deltaspeed

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_Projectile_body_entered(body):
	if body.is_in_group("enemy"):
		body.queue_free()
		queue_free()
