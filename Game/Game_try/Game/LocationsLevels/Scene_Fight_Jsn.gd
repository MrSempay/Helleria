extends Node2D

var her_1
var heroe_1

var triggered_enemies = {
	"Her": false,
	"Sed": false,
	"Jeison": false
}
var Sed_was_triggered = false
var Her_was_triggered
var jeison = preload("res://Game/Characters/Enemy55.tscn")
var sed = preload("res://Game/Characters/Sed.tscn")
var her = preload("res://Game/Characters/Her.tscn")
var enemys = ["Sed", "Her", "Jeison"]
var collisions = [1,2,3,9]
var floor_of_level = "First"
#var enemy_3 = preload("res://Game/Characters/Hir.tscn")

var heroe = preload("res://Game/Characters/Heroe.tscn")


func Fight_Scene():
	pass

func _ready():
	if self.has_node("Dialoge_Layer"):
		for i in range($Dialoge_Layer.get_children().size()):
			$Dialoge_Layer.get_children()[i].connect("body_entered", self, "_on_Dialoge_Area_body_entered", [$Dialoge_Layer.get_children()[i].get_name(),])
	heroe_1 = heroe.instance()
	heroe_1.position = $Position_Heroe.global_position
	self.add_child(heroe_1)
	heroe_1.set_collision_layer(3)
	heroe_1.set_collision_mask(3)
	
	var jeison_1 = jeison.instance()
	jeison_1.position = $Position_Jeison.global_position
	self.add_child(jeison_1)
	var sed_1 = sed.instance()
	sed_1.position = $Position_Sed.global_position
	self.add_child(sed_1)
	her_1 = her.instance()
	her_1.position = $Position_Her.global_position
	self.add_child(her_1)
	$Areas_For_Moving/Moving_Guards_Area_1.connect("body_entered", self, "_on_Area_For_Moving_After_Heroe_entered", [[self.get_node("Her"), self.get_node("Sed")], [Vector2(170,523), Vector2(170,523)], [false, false], "Moving_Guards_Area_1"])
	$Areas_For_Moving/Moving_Guards_Area_2.connect("body_entered", self, "_on_Area_For_Moving_After_Heroe_entered", [[self.get_node("Her"), self.get_node("Sed")], [Vector2(670,400), Vector2(670,400)], [false, false], "Moving_Guards_Area_2"])
	jeison_1.special_physics_process_controlling = true
	
	
func _physics_process(delta):
	if triggered_enemies["Her"]:
		if floor_of_level != "First" && (floor_of_level == "Moving_Guards_Area_1" && heroe_1.global_position.y > 433) or (floor_of_level == "Moving_Guards_Area_2" && heroe_1.global_position.y > 292) && !her_1.manual_navigation:
			print(true)
			her_1.should_be_triggered_after_manual_navigation = false
			her_1.speed = 4
			her_1.manual_navigation = true
			her_1.j = 0
			
			match floor_of_level:
				"Moving_Guards_Area_1":
					if heroe_1.global_position.y > 433:
						her_1.current_target = Vector2(323,386)
				"Moving_Guards_Area_2":
					if heroe_1.global_position.y > 292:
						her_1.current_target = Vector2(630,265)
						
			her_1.get_node("NavigationAgent2D").set_target_location(her_1.current_target)
			her_1.get_node("NavigationAgent2D").get_final_location()
			her_1.nav_path = her_1.get_node("NavigationAgent2D").get_nav_path()
		


func _on_Dialoge_Area_body_entered(body, dialoge_area_name):
	if get_node("Heroe/CanvasLayer/Dialoge_Field").file.is_open():
		get_node("Heroe/CanvasLayer/Dialoge_Field").file.close()
		get_node("Heroe/CanvasLayer/Dialoge_Field").set_visible(true)
		get_node("Heroe/CanvasLayer/Dialoge_Field").file.open("res://Dialoges/"+ self.get_name() + "/" + dialoge_area_name + ".txt", File.READ) 
		var k = str(get_node("Heroe/CanvasLayer/Dialoge_Field").file.get_line())
		get_node("Heroe/CanvasLayer/Dialoge_Field/Sprite").set_texture(load("res://Icons_For_Characters/" + k.split(":: ")[0] + ".jpg"))
		get_node("Heroe/CanvasLayer/Dialoge_Field/RichTextLabel").set_text(k.split(":: ")[1])
		get_node("Heroe/CanvasLayer/Dialoge_Field/RichTextLabel").set_text(k.split(":: ")[0])

	if (GLOBAL.dialoge_heroe_camera or GLOBAL.dialoge_No_heroe_camera) && !get_node("Heroe/CanvasLayer/Dialoge_Field").file.is_open():
		get_node("Heroe/CanvasLayer/Dialoge_Field").set_visible(true)
		get_node("Heroe/CanvasLayer/Dialoge_Field").file.open("res://Dialoges/"+ self.get_name() + "/" + dialoge_area_name + ".txt", File.READ) 
		var k = str(get_node("Heroe/CanvasLayer/Dialoge_Field").file.get_line())
		get_node("Heroe/CanvasLayer/Dialoge_Field/Sprite").set_texture(load("res://Icons_For_Characters/" + k.split(":: ")[0] + ".jpg"))
		get_node("Heroe/CanvasLayer/Dialoge_Field/RichTextLabel").set_text(k.split(":: ")[1])
		get_node("Heroe/CanvasLayer/Dialoge_Field/RichTextLabel2").set_text(k.split(":: ")[0])
		get_node("Dialoge_Layer/" + dialoge_area_name + "/CollisionShape2D").set_disabled(true)
	get_node("Dialoge_Layer/" + dialoge_area_name).queue_free()
		
func _on_Area_For_Moving_After_Heroe_entered(body, array_of_characters, array_of_target_points, stay_triggered, area_which_was_triggered):
	if body.has_method("start_jump_heroe"):
		for i in range(array_of_characters.size()):
			array_of_characters[i].animate("idle")
			array_of_characters[i].area_from_which_manual_navigation_was_started = area_which_was_triggered
			array_of_characters[i].should_be_triggered_after_manual_navigation = stay_triggered[i]
			array_of_characters[i].current_target = array_of_target_points[i]
			array_of_characters[i].speed = 4
			array_of_characters[i].get_node("NavigationAgent2D").set_target_location(array_of_target_points[i])
			array_of_characters[i].get_node("NavigationAgent2D").get_final_location()
			array_of_characters[i].nav_path = array_of_characters[i].get_node("NavigationAgent2D").get_nav_path()
			array_of_characters[i].manual_navigation = true
			array_of_characters[i].j = 0
			get_node("Areas_For_Moving/" + area_which_was_triggered).queue_free()
			
		
func already_finished_manual_navigation(name_character, area_from_which_manual_navigation_was_started):
	get_node(name_character).animate("idle")
	get_node(name_character).manual_navigation = false
	get_node(name_character).speed = 2.5
	floor_of_level = area_from_which_manual_navigation_was_started
	match area_from_which_manual_navigation_was_started:
		"Moving_Guards_Area_1":
			match name_character:
				"Her":
					
					get_node(name_character).set_global_position(Vector2(323,386))
					get_node(name_character).jumping_to_point_ready = true
				"Sed":
					get_node(name_character).set_global_position(Vector2(343,386))
					get_node(name_character).chaining_casted = false
		"Moving_Guards_Area_2":
			match name_character:
				"Her":
					get_node(name_character).set_global_position(Vector2(630,265))
					get_node(name_character).jumping_to_point_ready = true
				"Sed":
					get_node(name_character).set_global_position(Vector2(610,265))
					get_node(name_character).chaining_casted = false
	#get_node("Areas_For_Moving/" + area_from_which_manual_navigation_was_started).set_monitoring(false)
	if has_node("Areas_For_Moving/" + area_from_which_manual_navigation_was_started):
		get_node("Areas_For_Moving/" + area_from_which_manual_navigation_was_started).queue_free()
			
	
	
	
	
