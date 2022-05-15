extends Area2D

class_name Projectile

enum Direction {UP, DOWN, LEFT, RIGHT}

export var speed = 700

onready var direction: int =  Direction.UP

var delay = 5

func _physics_process(delta):
	delay -= 1
	if delay == 0:
		print("bla")
		delay = 5
	match direction:
		Direction.UP:
			position -= transform.y * speed * delta
		Direction.DOWN:
			position += transform.y * speed * delta
		Direction.LEFT:
			position -= transform.x * speed * delta
		Direction.RIGHT:
			position += transform.x * speed * delta


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
