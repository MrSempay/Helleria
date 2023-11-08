extends "res://Game/Characters.gd"
#var rand_sword = RandomNumberGenerator.new


func _ready():
	pass

func _physics_process(delta):
	#get_parent().get_node("Line2D21").set_points($NavigationAgent2D.get_nav_path())
	#get_parent().get_node("Line2D21").set_points([Vector2(777.5, 501.595032), Vector2(136.989716, 491.814545)])

	$Line2D2.set_points($NavigationAgent2D.get_nav_path())
	#print(get_parent().get_node("Line2D21").get_points())
	#print(speed)
	if get_parent().get_name() == "Garsia_Boss_Fight_Scene":
		if heroe != null && !stun && get_parent().has_method("Fight_Scene") && is_instance_valid(heroe):
			if $Sprite.get_animation()[0] != "A":
				#print(spells_ready["handle_attack_ready"])
				if is_on_floor() && get_parent().heroe_on_floor == "First" && get_parent().enemies_on_floor["Adalard"] == "First": 
					push()
				elif $Sprite.get_animation() == "A_push" or $Sprite.get_animation() == "A_push_preparing":
					stop_pushing = true
					special_physics_process_controlling = false
					spells_ready["push_ready"] = false
					get_node("Area_Pushing").set_monitoring(false)
					preparing_for_pushing_finished = false
					animate("idle")
				if ((self.global_position.x) - heroe.global_position.x < 52) && (self.global_position.x - heroe.global_position.x > -52) && is_on_floor() && $Sprite.get_animation() != "armor" && $Sprite.get_animation() != "push" && $Sprite.get_animation() != "push_preparing" && spells_ready["handle_attack_ready"] == true: 
					handle_attack()
			else:
				#print(spells_ready["handle_attack_ready"])
				#if ((self.global_position.x) - heroe.global_position.x < 52) && (self.global_position.x - heroe.global_position.x > -52) && is_on_floor() && $Sprite.get_animation() != "armor" && $Sprite.get_animation() != "push" && $Sprite.get_animation() != "push_preparing" && spells_ready["handle_attack_ready"] == true && $Sprite.get_animation().split("_")[1] != "handle": 
				#	handle_attack()
				if is_on_floor() && $Sprite.get_animation().split("_")[1] != "A_handle_attack" && get_parent().heroe_on_floor == "First" && get_parent().enemies_on_floor["Adalard"] == "First": 
					push()
				elif $Sprite.get_animation() == "A_push" or $Sprite.get_animation() == "A_push_preparing":
					stop_pushing = true
					special_physics_process_controlling = false
					spells_ready["push_ready"] = false
					get_node("Area_Pushing").set_monitoring(false)
					preparing_for_pushing_finished = false
					animate("idle")
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

