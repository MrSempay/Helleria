extends "res://Game/Characters.gd"
#var rand_sword = RandomNumberGenerator.new



func _physics_process(delta):
	#print($Sprite.get_animation())
	if get_parent().get_name() == "Garsia_Boss_Fight_Scene":
		if heroe != null && !stun && get_parent().has_method("Fight_Scene") && is_instance_valid(heroe):
				if $Sprite.get_animation()[0] != "A":
					#print(spells_ready["handle_attack_ready"])
					if is_on_floor() && get_parent().enemies_on_floor["Adalard"] == "First": 
						push()
					if ((self.global_position.x) - heroe.global_position.x < 52) && (self.global_position.x - heroe.global_position.x > -52) && is_on_floor() && $Sprite.get_animation() != "armor" && $Sprite.get_animation() != "push" && $Sprite.get_animation() != "push_preparing" && spells_ready["handle_attack_ready"] == true: 
						handle_attack()
				else:
					#print(spells_ready["handle_attack_ready"])
					#if ((self.global_position.x) - heroe.global_position.x < 52) && (self.global_position.x - heroe.global_position.x > -52) && is_on_floor() && $Sprite.get_animation() != "armor" && $Sprite.get_animation() != "push" && $Sprite.get_animation() != "push_preparing" && spells_ready["handle_attack_ready"] == true && $Sprite.get_animation().split("_")[1] != "handle": 
					#	handle_attack()
					if is_on_floor() && $Sprite.get_animation().split("_")[1] != "A_handle_attack"  && get_parent().enemies_on_floor["Adalard"] == "First": 
						push()
	else:
		if heroe != null && !stun && get_parent().has_method("Fight_Scene") && is_instance_valid(heroe):
				if $Sprite.get_animation()[0] != "A":
					#print(spells_ready["handle_attack_ready"])
					if is_on_floor(): 
						push()
					if ((self.global_position.x) - heroe.global_position.x < 52) && (self.global_position.x - heroe.global_position.x > -52) && is_on_floor() && $Sprite.get_animation() != "armor" && $Sprite.get_animation() != "push" && $Sprite.get_animation() != "push_preparing" && spells_ready["handle_attack_ready"] == true: 
						handle_attack()
				else:
					#print(spells_ready["handle_attack_ready"])
					#if ((self.global_position.x) - heroe.global_position.x < 52) && (self.global_position.x - heroe.global_position.x > -52) && is_on_floor() && $Sprite.get_animation() != "armor" && $Sprite.get_animation() != "push" && $Sprite.get_animation() != "push_preparing" && spells_ready["handle_attack_ready"] == true && $Sprite.get_animation().split("_")[1] != "handle": 
					#	handle_attack()
					if is_on_floor() && $Sprite.get_animation().split("_")[1] != "A_handle_attack": 
						push()
					
					
					
					
					
					
					"""rand_sword.randomize()
					var random_sword = rand_sword.randi_range(1, 3)
					$Sprite.flip_h = ((self.global_position.x) - heroe.global_position.x) > 0
					if ((self.global_position.x) - heroe.global_position.x) > 0:
						$Sword.set_position(Vector2(-25,-6))
					else:
						$Sword.set_position(Vector2(25,-6))
					speed = 0
					spells_ready["handle_attack"] = false
					animate("A_handle_attack" + str(random_sword))
					mana_using(SPELLS_PARAMETERS.characters[name_character]["handle_attack"]["handle_attack_manacost"])
"""

func _on_Area_Pushing_body_entered(body):
	
	stop_pushing = true
	
	if body.has_method("start_jump_heroe"):
		body.handle_hit(SPELLS_PARAMETERS.characters[name_character]["push"]["push_damage"], self)
		body.stun(SPELLS_PARAMETERS.characters[name_character]["push"]["push_stun"])
		#animate("idle")

