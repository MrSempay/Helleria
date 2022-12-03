extends Area2D


var damage = 10
var damage_save = 10


onready var anim = $AnimationPlayer
onready var shape = $CollisionShape2D
onready var anim_2 = get_node("../AnimationPlayer2")
onready var weapon_heroe = get_node("../../Heroe/Weapon")


var count_of_attack = 0


func _ready():
	shape.set_disabled(true)


func _process(delta):
	if GLOBAL.life_heroe == false:
		anim.stop(true)


func attack():
		anim.play("Attack_Animation")


func _on_Weapon_body_entered(body: Node) -> void: 
	if body.has_method("handle_hit") && body.has_method("start_jump"):
		count_of_attack += 1
		body.handle_hit(damage, damage_save)
		

		


func _on_Weapon_Enemy_area_entered(area: Area2D):
	count_of_attack += 1
