extends "res://Game/Characters.gd"


var was_triggered = true

var anim1 = AnimationPlayer.new()
var anim2 = AnimationPlayer.new()
var anim3 = AnimationPlayer.new()

var first_activating_Gasria_in_fight = true
var positions_for_current_targets = [Vector2(675, 25), Vector2(691, 184), Vector2(309, 289), Vector2(444, 484), Vector2(86, 57)]

var names_characters_which_have_to_be_called = []
 
func _ready():
	can_fly = true
	if get_parent().has_method("Fight_Scene"):
		var positions_for_characters_which_have_to_be_called = []
		for key in GLOBAL.died_enemies_at_first_level.keys():
			if GLOBAL.died_enemies_at_first_level[key] == true:
				names_characters_which_have_to_be_called.append(key)
				positions_for_characters_which_have_to_be_called.append(GLOBAL.position_for_died_enemies_at_Gasria_fight[key])
		spells_ready["call_of_the_dead_ready"] = true
		call_characters(names_characters_which_have_to_be_called, positions_for_characters_which_have_to_be_called, "call_of_the_dead", true)
		get_node("Trigger_Area").scale = Vector2(0.4, 1)
	if get_parent().get_name() == "First_Scene":
		if stone_wallInstanced == null:
			stone_wallInstanced = stone_wall.instance()
			stone_wallInstanced.creating_animations_for_wall_from_folder("res://Anims/Gasria/stone_wall/", {"idle": [7, true], "wall_growing": [55, false], "wall_destruction": [14, false]}, stone_wallInstanced.get_node("AnimatedSprite"))
	$Area_For_Starting_Fight.set_monitoring(false)
	if get_parent().has_node("Snares_Of_Boss"):
		for i in range(get_parent().get_node("Snares_Of_Boss").get_children().size()):
			get_parent().get_node("Snares_Of_Boss").get_children()[i].connect("body_entered", self, "_on_Snare_Area_body_entered", [get_parent().get_node("Snares_Of_Boss").get_children()[i]])

func _physics_process(delta):

	
	#print(get_parent().triggered_enemies[name_character])
	if get_parent().has_method("Fight_Scene") && heroe != null && is_instance_valid(heroe):
		if((self.global_position.x) - get_parent().get_node("Heroe").global_position.x) > 0:
			$FlyingProjectilePosition.set_position(Vector2(-34,-2))
			$RayCastFlyingProjectile.set_position(Vector2(-34,-2))
			$RayCastFlyingProjectile2.set_position(Vector2(-34,-1))
			$RayCastFlyingProjectile3.set_position(Vector2(-34,-3))
			$RayCastFlyingProjectile.set_cast_to(get_parent().get_node("Heroe").global_position - self.global_position - Vector2(-34,-5))
			$RayCastFlyingProjectile2.set_cast_to(get_parent().get_node("Heroe").global_position - self.global_position - Vector2(-34,-6))
			$RayCastFlyingProjectile3.set_cast_to(get_parent().get_node("Heroe").global_position - self.global_position - Vector2(-34,-4))
		else:
			$FlyingProjectilePosition.set_position(Vector2(34,-2))
			$RayCastFlyingProjectile.set_position(Vector2(34,-2))
			$RayCastFlyingProjectile2.set_position(Vector2(34,-1))
			$RayCastFlyingProjectile3.set_position(Vector2(34,-3))
			$RayCastFlyingProjectile.set_cast_to(get_parent().get_node("Heroe").global_position - self.global_position - Vector2(34,-5))
			$RayCastFlyingProjectile2.set_cast_to(get_parent().get_node("Heroe").global_position - self.global_position - Vector2(34,-6))
			$RayCastFlyingProjectile3.set_cast_to(get_parent().get_node("Heroe").global_position - self.global_position - Vector2(34,-4))
		#if ((self.global_position.x) - get_parent().get_node("Heroe").global_position.x) < 50:
		if get_parent().triggered_enemies[name_character] == true:
			if first_activating_Gasria_in_fight:
				auto_manual_navigation = true
				manual_navigation = true
				current_target = Vector2(675, 25)
				update_way()
				first_activating_Gasria_in_fight = false
				free_timers_for_consumption(timers_for_consumption_health_or_mana["call_of_the_dead"])
				for i in range(names_characters_which_have_to_be_called.size()):
					if is_instance_valid(get_parent().get_node(names_characters_which_have_to_be_called[i])):
						get_parent().get_node(names_characters_which_have_to_be_called[i]).queue_free()
			if abs(self.global_position.x - current_target.x) < 3 && abs(self.global_position.y - current_target.y) < 20:
				current_target = positions_for_current_targets[randi() % positions_for_current_targets.size()]
				update_way()
			invisibility("target_came_up", heroe)
			if modulate.a == 0:
				flying_projectile("fier_ball", 100, 2000, true)
			else:
				flying_projectile("fier_ball", 75, 2000, true)



func not_enough_mana_for_ongoing_spell(name_spell, timer):
	timer.queue_free()
	match name_spell.left(name_spell.length() - 6):
		"invisibility":
			if modulate.a != 1:
				get_node("AnimationInvisibility").play("animation_out_from_invisibility")



func _on_Snare_Area_body_entered(body, snare_which_was_activated):
	#yield(get_tree(), "idle_frame")
	#yield(get_tree(), "idle_frame")
	if get_parent().triggered_enemies[name_character] == true && body.has_method("start_jump_heroe"):
		snare_which_was_activated.set_deferred("monitoring", false)
		var position_for_wave = snare_which_was_activated.get_node("PositionsWalls/Position2D2").global_position
		if snare_which_was_activated.get_node("PositionsWalls").get_children().size() == 3:
			var position_for_wall = snare_which_was_activated.get_node("PositionsWalls/Position2D").global_position
			#print(snare_which_was_activated.get_node("PositionsWalls").get_children())
			for i in range(snare_which_was_activated.get_node("PositionsWalls").get_children().size()):
				#print(snare_which_was_activated.get_node("PositionsWalls").get_children()[i].get_name()[0])
				if snare_which_was_activated.get_node("PositionsWalls").get_children()[i].get_name()[0] == "S":
					#print(snare_which_was_activated.get_node("PositionsWalls").get_children()[i].global_position)
					#print(snare_which_was_activated.get_node("PositionsWalls/Position2D").global_position)
					if snare_which_was_activated.get_node("PositionsWalls").get_children()[i].global_position == snare_which_was_activated.get_node("PositionsWalls/Position2D").global_position:
						#print(true)
						position_for_wall = snare_which_was_activated.get_node("PositionsWalls/Position2D2").global_position
						position_for_wave = snare_which_was_activated.get_node("PositionsWalls/Position2D").global_position
			stone_wall(position_for_wall, false, snare_which_was_activated.get_node("PositionsWalls"))
			#destruction_wave(position_for_wave, snare_which_was_activated)
		elif snare_which_was_activated.get_node("PositionsWalls").get_children().size() == 2:
			stone_wall(snare_which_was_activated.get_node("PositionsWalls/Position2D").global_position, false, snare_which_was_activated.get_node("PositionsWalls"))
			stone_wall(snare_which_was_activated.get_node("PositionsWalls/Position2D2").global_position, false, snare_which_was_activated.get_node("PositionsWalls"))
		destruction_wave(position_for_wave, snare_which_was_activated)
		creating_timer_for_calldown_snare(snare_which_was_activated)
		
		
func creating_timer_for_calldown_snare(snare_which_was_activated):
	var timer_for_calldown_snare = Timer.new()
	timer_for_calldown_snare.set_wait_time(SPELLS_PARAMETERS.characters[name_character]["stone_wall"]["stone_wall_calldown_snare"])
	timer_for_calldown_snare.connect("timeout", self, "_on_stone_wall_calldown_snare_timeout", [snare_which_was_activated, timer_for_calldown_snare])
	timer_for_calldown_snare.one_shot = true
	$Timers.add_child(timer_for_calldown_snare)
	timer_for_calldown_snare.start()
	
		
func _on_stone_wall_calldown_snare_timeout(snare_which_was_activated, timer_for_calldown_snare):
	snare_which_was_activated.set_monitoring(true)
	timer_for_calldown_snare.queue_free()
	
func destruction_wave(position_for_wave, snare_which_was_activated):
	var wave1 = wave.instance()
	wave1.local_parameters["should_be_destroing_after_colliding"] = false
	wave1.local_parameters["name"] = "Wave_Of_Destruction" + str(self.global_position.x + get_parent().global_position.x)
	wave1.local_parameters["name_of_wave"] = "destruction"
	wave1.local_parameters["character_who_casted_wave"] = name_character
	wave1.local_parameters["global_position_for_wave"] = position_for_wave
	snare_which_was_activated.get_node("For_Waves").add_child(wave1)


func _on_Area_For_Wall_Detecting_body_entered(body):
	if body.has_method("stone_wall_self"):
		body.get_node("AnimatedSprite").play("wall_destruction")


func _on_VisibilityNotifier2D_screen_entered():
	special_physics_process_controlling = false


