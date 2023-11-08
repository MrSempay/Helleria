extends "res://Game/Characters.gd"

var targets_for_interaction = ["Her", "Sed"]


func _ready():
	animate("idle")


func _physics_process(delta):
	#print(self.global_position)
	if get_parent().has_node("Heroe"):
		if heroe == null:
			if((self.global_position.x) - get_parent().get_node("Heroe").global_position.x) > 0:
				$Sprite.flip_h = true
			else:
				$Sprite.flip_h = false
	else:
		heroe = null
	
	if heroe != null && !stun && get_parent().has_method("Fight_Scene"):
		print("???")
		if get_parent().triggered_enemies[name_character] && !get_parent().get_node("Heroe").in_invisibility: 
			#chain("damage_block", [get_parent().get_node("Her"), get_parent().get_node("Sed")])
			chain("damage_block", [get_parent().get_node("Her")])
			#chain("cure", [get_parent().get_node("Her"), get_parent().get_node("Sed")])
			chain("cure", [get_parent().get_node("Her")])
			#chain("damage_increase", [get_parent().get_node("Her"), get_parent().get_node("Sed")])
			chain("damage_increase", [get_parent().get_node("Her")])
		


