extends Area2D


var manacost = 100
var stown = 20
var SPEED = 400
var velocity = Vector2()
var damage_stone = 10
var vector = 0

onready var enemy = get_parent().get_node("Sprite")


func _ready():
	if enemy.is_flipped_h():
		$Sprite.flip_h = 1
	else: 
		$Sprite.flip_h = -1


func _physics_process(delta):
	if GLOBAL.vector_of_moving >= 0:
		velocity.x = SPEED * delta * vector
		translate(velocity)
	else:
		velocity.x = SPEED * delta * vector
		translate(velocity)


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()



func _on_Stone_body_entered(body):
	if body.has_method("handle_hit") && !body.has_method("start_jump"):
		body.handle_hit(damage_stone)
	if !body.has_method("start_jump"):
		queue_free()
