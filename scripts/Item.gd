extends Area2D

class_name Item

var window_size

func _ready() -> void:
	window_size = get_viewport_rect().size
	position = Vector2(window_size.x/2, window_size.y/2+100)

func _on_Item_body_entered(body: Node2D) -> void:
	if body is Player:
		call_deferred("free")
