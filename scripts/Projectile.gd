extends Area2D

class_name Projectile

enum Direction {UP, DOWN, LEFT, RIGHT}

export var speed = 700

onready var direction: int =  Direction.UP

func _physics_process(delta):
	match direction:
		Direction.UP:
			position -= transform.y * speed * delta
		Direction.DOWN:
			position += transform.y * speed * delta
		Direction.LEFT:
			position -= transform.x * speed * delta
		Direction.RIGHT:
			position += transform.x * speed * delta
