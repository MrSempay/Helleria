extends Area2D

var manacost = 100
var stown = 20
var velocity = Vector2.ZERO
var vector = Vector2.ZERO

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
	
	match $Sprite.get_animation():
		"stone_lifting":
			$Sprite.set_speed_scale(SPELLS_PARAMETERS.scale_animation_speed_stone_Belotur)
		"stone_flying":
			$Sprite.set_speed_scale(1)
		
	
	if $Sprite.get_animation() == "stone_flying":
		collision_of_stone.set_disabled(false)
		velocity = SPELLS_PARAMETERS.speed_stone_Belotur * delta * vector.normalized()
		translate(velocity)


func _on_VisibilityNotifier2D_screen_exited():
	if get_parent().has_node("Heroe"):
		if heroe.is_on_floor():
			queue_free()
	pass
		

func _on_Stone_body_entered(body):
	if body.has_method("handle_hit") && body.has_method("start_jump_heroe"):
		body.handle_hit(SPELLS_PARAMETERS.damage_stone_Belotur, get_parent().get_node("Belotur"))
		queue_free()
	if !body.has_method("handle_hit"):
		queue_free()


func _on_Sprite_animation_finished():
	if $Sprite.get_animation() == "stone_lifting":
		$Sprite.play("stone_flying")
