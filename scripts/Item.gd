extends Area2D

var window_size
signal consumed

func _ready():
	window_size = get_viewport_rect().size
	position = Vector2(window_size.x/2, window_size.y/2+100)

func _on_Item_body_entered(body):
	emit_signal("consumed")
	visible = false
