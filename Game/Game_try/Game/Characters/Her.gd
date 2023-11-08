extends "res://Game/Characters.gd"


func _ready():
	pass


func _physics_process(delta):
	#print(self.global_position)

	
	if is_instance_valid(heroe) && !stun:
		if get_parent().triggered_enemies[name_character] && get_parent().has_method("Fight_Scene") && !get_parent().get_node("Heroe").in_invisibility: 
#			if (self.global_position.x < get_parent().get_node("Sed").global_position.x && get_parent().get_node("Sed").global_position.x < get_parent().get_node("Heroe").global_position.x) or (self.global_position.x > get_parent().get_node("Sed").global_position.x && get_parent().get_node("Sed").global_position.x > get_parent().get_node("Heroe").global_position.x):
#				self.jumping_to_point(Vector2(heroe.global_position.x + 50 * sign(heroe.global_position.x - self.global_position.x), heroe.global_position.y), 150)
			self.squall_attack(SPELLS_PARAMETERS.characters[name_character]["squall_attack"]["squall_attack_amount_attacks"])
			self.handle_attack()
"""
						if((self.global_position.x) - heroe.global_position.x) > 0:
							$Sprite.flip_h = true
						else:
							$Sprite.flip_h = false
						speed = 0
						$Timer_Spear_Punch.set_wait_time(SPELLS_PARAMETERS.calldown_shield_punch_Sed)
						$Timer_Spear_Punch.start()
						handle_attack_ready = false
						animate("spear_punch")

func _on_Handle_Attack_body_entered(body):
	if body.has_method("handle_hit") && body.has_method("start_jump_heroe"):
		body.handle_hit(SPELLS_PARAMETERS.damage_shield_punch_Sed)



func _on_Sprite_animation_finished():
	if $Sprite.get_animation() == "spear_punch":
		animate("idle")
		speed = 2.5
		mana_using(SPELLS_PARAMETERS.manacost_spear_punch_Her)
		print(true)
		$Handle_Attack/CollisionShape2D.set_disabled(false)
"""


