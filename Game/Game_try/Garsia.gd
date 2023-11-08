extends "res://Game/Characters.gd"

var was_triggered = true

func _physics_process(delta):
	pass
	#print(self.get_collision_layer_bit(2))
	#print(self.get_collision_layer_bit(9))
	#print(current_target)
	#print(target_points_for_manual_navigation)
	#print(manual_navigation)

func _ready():
	$Area_For_Starting_Fight.set_monitoring(false)
	if get_parent().has_node("Snares_Of_Boss"):
		for i in range(get_parent().get_node("Snares_Of_Boss").get_children().size()):
			get_parent().get_node("Snares_Of_Boss").get_children()[i].connect("body_entered", self, "_on_Snare_Area_body_entered", [get_parent().get_node("Snares_Of_Boss").get_children()[i]])



func _on_Snare_Area_body_entered(body, snare_which_was_activated):

	if was_triggered && body.has_method("start_jump_heroe"):
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
		var timer_for_calldown_snare = Timer.new()
		timer_for_calldown_snare.set_wait_time(SPELLS_PARAMETERS.characters[name_character]["stone_wall"]["stone_wall_calldown_snare"])
		timer_for_calldown_snare.connect("timeout", self, "_on_stone_wall_calldown_snare_timeout", [snare_which_was_activated, timer_for_calldown_snare])
		timer_for_calldown_snare.one_shot = true
		self.add_child(timer_for_calldown_snare)
		timer_for_calldown_snare.start()
		
func _on_stone_wall_calldown_snare_timeout(snare_which_was_activated, timer_for_calldown_snare):
	snare_which_was_activated.set_monitoring(true)
	timer_for_calldown_snare.queue_free()
	
func destruction_wave(position_for_wave, snare_which_was_activated):
	var wave1 = wave.instance()
	wave1.should_be_destroing_after_colliding = false
	wave1.name_of_wave = "destruction"
	wave1.character_who_casted_wave = self
	wave1.global_position_for_wave = position_for_wave
	snare_which_was_activated.add_child(wave1)


func _on_Area_For_Wall_Detecting_body_entered(body):
	if body.has_method("stone_wall_self"):
		body.get_node("AnimatedSprite").play("wall_destruction")


func _on_VisibilityNotifier2D_screen_entered():
	special_physics_process_controlling = false


