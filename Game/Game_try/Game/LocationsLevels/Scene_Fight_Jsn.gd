extends "res://Locations.gd"
var her_1
"""
var heroe_1



var Her_was_triggered
var jeison = preload("res://Game/Characters/Enemy55.tscn")
var sed = preload("res://Game/Characters/Sed.tscn")
var her = preload("res://Game/Characters/Her.tscn")
var enemys = ["Sed", "Her", "Jeison"]
#var enemy_3 = preload("res://Game/Characters/Hir.tscn")

var heroe = preload("res://Game/Characters/Heroe.tscn")
"""
var Sed_was_triggered = false
var collisions = [1,2,3,9]
var floor_of_level = "First"

func Fight_Scene():
	pass

func _ready():
	"""if self.has_node("Dialoge_Layer"):
		for i in range($Dialoge_Layer.get_children().size()):
			$Dialoge_Layer.get_children()[i].connect("body_entered", self, "_on_Dialoge_Area_body_entered", [$Dialoge_Layer.get_children()[i].get_name()])
	if self.has_node("Areas_For_Moving"):
		for i in range($Areas_For_Moving.get_children().size()):
			$Areas_For_Moving.get_children()[i].connect("body_entered", self, "_on_Area_For_Moving_After_Heroe_entered", [LOCATIONS_PARAMETERS.locations[self.get_name()]["Areas_For_Moving"][$Areas_For_Moving.get_children()[i].get_name()]])
	heroe_1 = heroe.instance()
	heroe_1.position = $Position_Heroe.global_position
	self.add_child(heroe_1)"""
	heroe1.set_collision_layer(3)
	heroe1.set_collision_mask(3)
	"""
	var jeison_1 = jeison.instance()
	jeison_1.position = $Position_Jeison.global_position
	self.add_child(jeison_1)
	var sed_1 = sed.instance()
	sed_1.position = $Position_Sed.global_position
	self.add_child(sed_1)
	her_1 = her.instance()
	her_1.position = $Position_Her.global_position
	self.add_child(her_1)"""
	#$Areas_For_Moving/Moving_Area_1.connect("body_entered", self, "_on_Area_For_Moving_After_Heroe_entered", [[self.get_node("Her"), self.get_node("Sed")], [[Vector2(170,523)], [Vector2(170,523)]], [false, false], "Moving_Area_1"])
	#$Areas_For_Moving/Moving_Area_2.connect("body_entered", self, "_on_Area_For_Moving_After_Heroe_entered", [[self.get_node("Her"), self.get_node("Sed")], [[Vector2(670,400)], [Vector2(670,400)]], [false, false], "Moving_Area_2"])
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
	
	
	
