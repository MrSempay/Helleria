extends Node2D

var triggered_enemies = {}
var enemies_fight_scenes = {}
var enemies = []                #будет массив ОБЪЕКТОВ
var heroe = preload("res://Game/Characters/Heroe.tscn")
var heroe1

func _ready():
	heroe1 = heroe.instance()
	heroe1.position = $Position_Heroe.global_position
	self.add_child(heroe1)
	for i in range(LOCATIONS_PARAMETERS.locations[self.get_name()]["characters_for_uploading"].size()):
		triggered_enemies[LOCATIONS_PARAMETERS.locations[self.get_name()]["characters_for_uploading"][i]] = false
		var enemy = load("res://Game/Characters/" + LOCATIONS_PARAMETERS.locations[self.get_name()]["characters_for_uploading"][i] + ".tscn")
		enemies.append(enemy.instance())
		enemies[i].position = get_node("Positions_For_Enemies/Position_" + LOCATIONS_PARAMETERS.locations[self.get_name()]["characters_for_uploading"][i]).global_position
		self.add_child(enemies[i])
	
	if self.has_node("Dialoge_Layer"):
		for i in range($Dialoge_Layer.get_children().size()):
			$Dialoge_Layer.get_children()[i].connect("body_entered", self, "_on_Dialoge_Area_body_entered", [$Dialoge_Layer.get_children()[i].get_name()])
	if self.has_node("Areas_For_Moving"):
		for i in range($Areas_For_Moving.get_children().size()):
			$Areas_For_Moving.get_children()[i].connect("body_entered", self, "_on_Area_For_Moving_After_Heroe_entered", [LOCATIONS_PARAMETERS.locations[self.get_name()]["Areas_For_Moving"][$Areas_For_Moving.get_children()[i].get_name()]])
	#print(triggered_enemies)
	#print(enemys)
		
func _on_Dialoge_Area_body_entered(body, dialoge_area_name):
	if get_node("Heroe/CanvasLayer/Dialoge_Field").file.is_open():
		get_node("Heroe/CanvasLayer/Dialoge_Field").file.close()
		get_node("Heroe/CanvasLayer/Dialoge_Field").current_scene = self
		get_node("Heroe/CanvasLayer/Dialoge_Field").dialoge_name = dialoge_area_name
		get_node("Heroe/CanvasLayer/Dialoge_Field").set_visible(true)
		get_node("Heroe/CanvasLayer/Dialoge_Field").file.open("res://Dialoges/"+ self.get_name() + "/" + dialoge_area_name + ".txt", File.READ) 
		var k = str(get_node("Heroe/CanvasLayer/Dialoge_Field").file.get_line())
		get_node("Heroe/CanvasLayer/Dialoge_Field/Sprite").set_texture(load("res://Icons_For_Characters/" + k.split(":: ")[0] + ".jpg"))
		get_node("Heroe/CanvasLayer/Dialoge_Field/RichTextLabel").set_text(k.split(":: ")[1])
		get_node("Heroe/CanvasLayer/Dialoge_Field/RichTextLabel2").set_text(k.split(":: ")[0])

	if (GLOBAL.dialoge_heroe_camera or GLOBAL.dialoge_No_heroe_camera) && !get_node("Heroe/CanvasLayer/Dialoge_Field").file.is_open():
		get_node("Heroe/CanvasLayer/Dialoge_Field").set_visible(true)
		get_node("Heroe/CanvasLayer/Dialoge_Field").current_scene = self
		get_node("Heroe/CanvasLayer/Dialoge_Field").dialoge_name = dialoge_area_name
		get_node("Heroe/CanvasLayer/Dialoge_Field").file.open("res://Dialoges/"+ self.get_name() + "/" + dialoge_area_name + ".txt", File.READ) 
		var k = str(get_node("Heroe/CanvasLayer/Dialoge_Field").file.get_line())
		get_node("Heroe/CanvasLayer/Dialoge_Field/Sprite").set_texture(load("res://Icons_For_Characters/" + k.split(":: ")[0] + ".jpg"))
		get_node("Heroe/CanvasLayer/Dialoge_Field/RichTextLabel").set_text(k.split(":: ")[1])
		get_node("Heroe/CanvasLayer/Dialoge_Field/RichTextLabel2").set_text(k.split(":: ")[0])
		get_node("Dialoge_Layer/" + dialoge_area_name + "/CollisionShape2D").set_disabled(true)
	get_node("Dialoge_Layer/" + dialoge_area_name).queue_free()



func _on_Area_For_Moving_After_Heroe_entered(body, array):
	if body.has_method("start_jump_heroe"):
		for i in range(array[0].size()):
			var character = get_node(array[0][i])
			character.animate("idle")
			character.area_from_which_manual_navigation_was_started = array[3]
			character.should_be_triggered_after_manual_navigation = array[2][i]
			character.current_target = array[1][i][0]
			character.target_points_for_manual_navigation = array[1][i]
			character.update_way()
			character.target_points_for_manual_navigation.remove(0)
			character.speed = 4
			character.manual_navigation = true
			get_node("Areas_For_Moving/" + array[3]).queue_free()
