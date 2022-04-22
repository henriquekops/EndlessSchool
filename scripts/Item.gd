extends Area2D

class_name Item

signal consumed(type, effect)

export var type: String = "passive"
export var effect: String = "velocity"

onready var window_size: Vector2 = get_viewport_rect().size

func _ready() -> void:
	position = Vector2(window_size.x/2, window_size.y/2+100)

func _on_Item_body_entered(body: Node) -> void:
	if body != null:
		if body.name == "Player":
			emit_signal("consumed", type, effect)
			call_deferred("free")
