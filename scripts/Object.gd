extends StaticBody2D

class_name StaticObject

onready var window_size: Vector2 = get_viewport_rect().size

func _ready() -> void:	
	position = Vector2(window_size.x/2, window_size.y/2)
