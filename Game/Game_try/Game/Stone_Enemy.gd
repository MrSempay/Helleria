extends Area2D


var manacost = 100
var stown = 20
var SPEED = 200
var velocity = Vector2()
var damage_stone = 10
var vector = 1

onready var heroe = get_node("../Heroe")
onready var enemy = get_parent().get_node("Belotur/Sprite")
onready var collision_of_stone = get_node("CollisionShape2D")

func _ready():
	$Sprite.play("stone_lifting")
	if get_node("../Belotur/RayCastStone").get_collider():
		vector = get_node("../Heroe").global_position - self.global_position + Vector2(0,7)
	if enemy.is_flipped_h():
		$Sprite.flip_h = 1
	else:
		$Sprite.flip_h = -1


func _physics_process(delta):
	if $Sprite.get_animation() == "stone_flying":
		print(vector)
		collision_of_stone.set_disabled(false)
		velocity = SPEED * delta * vector.normalized()
		translate(velocity)


func _on_VisibilityNotifier2D_screen_exited():
	if heroe.is_on_floor():
		queue_free()
	pass
		

func _on_Stone_body_entered(body):
	if body.has_method("handle_hit") && body.has_method("start_jump_heroe"):
		body.handle_hit(damage_stone)
		queue_free()
	if !body.has_method("handle_hit"):
		queue_free()


func _on_Sprite_animation_finished():
	if $Sprite.get_animation() == "stone_lifting":
		$Sprite.play("stone_flying")
