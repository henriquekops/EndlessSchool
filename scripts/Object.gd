extends StaticBody2D

class_name StaticObject

var window_size

func _ready():
	window_size = get_viewport_rect().size
	position = Vector2(window_size.x/2, window_size.y/2)
