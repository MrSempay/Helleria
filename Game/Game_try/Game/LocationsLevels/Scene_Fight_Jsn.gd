extends "res://Locations.gd"
var her_1


var Sed_was_triggered = false
var collisions = [1,2,3,9]
var floor_of_level = "First"

func Fight_Scene():
	pass

func _ready():


	get_node("Dialoge_Layer/Dialoge_Area_4").disconnect("body_entered", self, "dialoge_start")
	get_node("Dialoge_Layer/Dialoge_Area_4").connect("body_entered", self, "dialoge_start", ["Dialoge_Area_4", "First_Scene"])
	GLOBAL.cameras["Heroe/CanvasLayer"] = true
	GLOBAL.first_cat_scene = false
	get_node("Sed").set_collision_layer_bit(0, true)
	get_node("Sed").set_collision_mask_bit(0, true)
	#heroe1.set_collision_layer(3)
	#heroe1.set_collision_mask(3)
	get_node("Jeison").special_physics_process_controlling = true
	her_1 = get_node("Her")
	
	
func _physics_process(delta):
	if triggered_enemies["Her"]:
		if floor_of_level != "First" && (floor_of_level == "Moving_Area_1" && heroe1.global_position.y > 433) or (floor_of_level == "Moving_Area_2" && heroe1.global_position.y > 292) && !her_1.manual_navigation:
			
			her_1.should_be_triggered_after_manual_navigation = false
			her_1.speed = 4
			her_1.manual_navigation = true
			her_1.j = 0
			
			match floor_of_level:
				"Moving_Area_1":
					if heroe1.global_position.y > 433:
						her_1.current_target = Vector2(280,386)
				"Moving_Area_2":
					if heroe1.global_position.y > 292:
						her_1.current_target = Vector2(650,265)
						
			her_1.get_node("NavigationAgent2D").set_target_location(her_1.current_target)
			her_1.get_node("NavigationAgent2D").get_final_location()
			her_1.nav_path = her_1.get_node("NavigationAgent2D").get_nav_path()
		
			
			
		
func already_finished_manual_navigation_which_started_from_area_entering(name_character, area_from_which_manual_navigation_was_started):
	var character = get_node(name_character)
	match area_from_which_manual_navigation_was_started:
		"Moving_Area_1":
			match name_character:
				"Her":
					character.set_global_position(Vector2(280,386))
					character.spells_ready["jumping_to_point_ready"] = true
					floor_of_level = area_from_which_manual_navigation_was_started
				"Sed":
					character.set_global_position(Vector2(343,386))
					character.chaining_casted = false
		"Moving_Area_2":
			match name_character:
				"Her":
					character.set_global_position(Vector2(650,265))
					character.spells_ready["jumping_to_point_ready"] = true
					floor_of_level = area_from_which_manual_navigation_was_started
				"Sed":
					character.set_global_position(Vector2(610,265))
					character.chaining_casted = false
	#get_node("Areas_For_Moving/" + area_from_which_manual_navigation_was_started).set_monitoring(false)
	if has_node("Areas_For_Moving/" + area_from_which_manual_navigation_was_started):
		get_node("Areas_For_Moving/" + area_from_which_manual_navigation_was_started).queue_free()
			
func dialoge_finished(dialoge_name):
	pass
	

func changing_scene_if_enemies_die(name_character, name_target_scene):
	if name_character == "Jeison":
		start_transition_between_scenes_with_dialogue(name_target_scene)
	
