extends KinematicBody2D

class_name Player

export var speed: int = 400

var velocity: Vector2
var collision: KinematicCollision2D

onready var screen_size: Vector2 = get_viewport_rect().size
onready var timer: Timer = $Timer
onready var item: Item = get_node("../Item")

#sala atual

var curRoomX = 1;
var curRoomY = 1;


var level: int = 1;

var random = RandomNumberGenerator.new();

func _ready() -> void:
	
	random.randomize();
	position = Vector2((screen_size.x/2) - ($Sprite.scale.x*2), screen_size.y/2)
	timer.connect("timeout", self, "_on_Timer_timeout")
	item.connect("consumed", self, "_on_Item_consumed")

func _physics_process(delta: float) -> void:
	velocity = move().normalized() * speed * delta
	position.x = clamp(position.x, 50, screen_size.x-50)
	position.y = clamp(position.y, 50, screen_size.y-50)
	collision = move_and_collide(velocity)
	if collision != null:
		if collision.collider.name == "Enemy":
			call_deferred("free")
		elif collision.collider.name.begins_with("Porta"):
			entra_porta(collision.collider);
func _on_Item_consumed(type: String, effect: String):
	if type == "passive":
		if effect == "velocity":
			speed = speed * 2
		timer.start(5)

func _on_Timer_timeout():
	speed = speed / 2
	timer.stop()

func move() -> Vector2:
	velocity = Vector2.ZERO
	if Input.is_action_pressed("Move Up"):
		velocity.y -= 1
	if Input.is_action_pressed("Move Down"):
		velocity.y += 1
	if Input.is_action_pressed("Move Right"):
		velocity.x += 1
	if Input.is_action_pressed("Move Left"):
		velocity.x -= 1
	return velocity

func entra_porta(porta: StaticBody2D):
	level+= 1;
	var xbefore = 0;
	var ybefore = 0;
	if porta.position.x < screen_size.x / 2:	
		xbefore = -1;
	else:
		xbefore = 1;
	if porta.position.y < screen_size.y / 2:
		ybefore = 	-1;
	else:
		ybefore = 1;
		
	if xbefore == -1 and ybefore == 1:
		position.x = screen_size.x - 20;
		position.y =  screen_size.y / 2;
		
		var i = random.randi() % 3;
		if i == 0:
			porta.position.x = 20;
			porta.position.y = screen_size.y / 2;
		elif i == 2:
			porta.position.y = screen_size.y -20;
			porta.position.x = screen_size.x / 2;
		else:
			porta.position.y = 20;
			porta.position.x = screen_size.x / 2;
	if xbefore == 1 and ybefore == -1:
		position.y =  screen_size.y - 20;
		position.x =screen_size.x / 2;
		var i = random.randi() % 3;
		if i == 0:
			porta.position.x = screen_size.x / 2;
			porta.position.y = 20;
		elif i == 2:
			porta.position.y = screen_size.y / 2;
			porta.position.x = screen_size.x - 20;
		else:
			porta.position.y = screen_size.y / 2;
			porta.position.x = 20;
		
	if xbefore == -1 and ybefore ==-1:
		position.y =  screen_size.y - 20;
		position.x = screen_size.x / 2;
		var i = random.randi() % 3;
		if i == 0:
			porta.position.x = 20;
			porta.position.y = screen_size.y / 2;
		elif i == 2:
			porta.position.y = screen_size.y / 2;
			porta.position.x = screen_size.x - 20;
		else:
			porta.position.x = screen_size.x / 2;
			porta.position.y = 20;
		
	if xbefore == 1 and ybefore == 1:
		position.y =  20;
		position.x = screen_size.x / 2;
		var i = random.randi() % 3;
		if i == 0:
			porta.position.x = screen_size.x / 2;
			porta.position.y = screen_size.y - 20;
		elif i == 2:
			porta.position.y = screen_size.y / 2;
			porta.position.x = screen_size.x - 20;
		else:
			porta.position.y = screen_size.y / 2;
			porta.position.x = 20;
		
