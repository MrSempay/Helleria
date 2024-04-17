extends Node2D

onready var area_of_dialoge_camera = get_node("Camera_For_Speaking/Area_Of_Dialoge_Camera")


var in_area_for_artifical_intelligance_controlling_1 = [0,0,0,0,0,0,0,0]
var in_area_for_artifical_intelligance_controlling_2 = [0,0,0,0,0,0,0,0]
var in_area_for_artifical_intelligance_controlling_3 = [0,0,0,0,0,0,0,0]
var in_area_for_artifical_intelligance_controlling_4 = [0,0,0,0,0,0,0,0]
var point_1
var point_2
var point_3
var mass_of_points = []
var current_target = Vector2(0,0)
var current_target_Adalard = Vector2(0,0)
var current_target_Aglea = Vector2(0,0)
var current_target_Akira = Vector2(0,0)
var current_target_Belotur = Vector2(0,0)
var current_target_Jeison = Vector2(0,0)
var position_enemy = ""
var Belotur_was_triggered = false
var Jeison_was_triggered = false
var Adalard_was_triggered = false

var enemies = []   
var positions_for_positions = {
	
}
var triggered_enemies = {"Adalard": false, "Belotur": false, "Jeison": false, "Garsia": false, "Akira": false, "Aglea": false}

#var ally = preload("res://Game/Characters/Ally.tscn")
var enemy_1 = preload("res://Game/Characters/Akira.tscn")
var enemy_2 = preload("res://Game/Characters/Adalard.tscn")
var enemy_3 = preload("res://Game/Characters/Belotur.tscn")
var enemy_4 = preload("res://Game/Characters/Aglea.tscn")
var enemy_5 = preload("res://Game/Characters/Jeison.tscn")
var Garsia = preload("res://Game/Characters/Garsia.tscn")

var heroe = preload("res://Game/Characters/Heroe.tscn")
var door = preload("res://Game/Tile_setsTools_for_level/Tools_for_level/Doors/Door.tscn")

#var ally_1 = ally.instance()
var enemy_1_1 = enemy_1.instance()
var enemy_1_2 = enemy_2.instance()
var enemy_1_3 = enemy_3.instance()
var enemy_1_4 = enemy_4.instance()
var enemy_1_5 = enemy_5.instance()
var Garsia1 = Garsia.instance()
var heroe_1 = heroe.instance()
var door_1 = door.instance()


var stop_Aglea_1M = false
var stop_Belotur_1M = false
var stop_Adalard_1M = false
var stop_Akira_1M = false
var stop_Jeison_1M = false
var stop_Aglea_1D = false
var stop_Akira_1D = false
var stop_Heroe_1M = false


var first_position_Adalard = Vector2(2478, 1400)
var first_position_Aglea 
var first_position_Akira
var first_position_Belotur = Vector2(1600, 1340)
var first_position_Jeison = Vector2(2000, 1190)

var fight_scene_for_Belotur = "Max_level_Fight_Scene"
var file_name = "Scene_1_Dialoge_1_AgleaBelotur"

var file = File.new()
signal dialoge_started

func First_Scene():
	pass


func _ready():
	for key in LOCATIONS_PARAMETERS.locations[self.get_name()]["characters_for_uploading"].keys():
		if GLOBAL.died_enemies_at_first_level[key] == false:
			#print(key)
			var enemy = load("res://Game/Characters/" + key + ".tscn")
			enemies.append(enemy.instance())
			#print(enemies)
	if !GLOBAL.cameras["Enemy_Camera"]:
		if GLOBAL.first_cat_scene:
			triggered_enemies = {"Adalard": true, "Belotur": true, "Jeison": true, "Garsia": false, "Akira": true, "Aglea": true}
			GLOBAL.cameras = {"Heroe/CanvasLayer": false, "Camera_For_Speaking": true, "Enemy_Camera": false}
		else:
			GLOBAL.cameras = {"Heroe/CanvasLayer": true, "Camera_For_Speaking": false, "Enemy_Camera": false}
	
	if self.has_node("Dialoge_Layer"):
		for i in range($Dialoge_Layer.get_children().size()):
			$Dialoge_Layer.get_children()[i].connect("body_entered", self, "dialoge_start", [$Dialoge_Layer.get_children()[i].get_name()])
	#$Areas_For_Moving/Moving_Garsia_Area_1.connect("body_entered", self, "_on_Area_For_Moving_After_Heroe_entered", [[self.get_node("Garsia")], [Vector2(170,523)], [false], "Moving_Guards_Area_1"])
	if self.has_node("Snares_Of_Boss"):
		for i in range($Snares_Of_Boss.get_children().size()):
			if $Snares_Of_Boss.get_children()[i].has_node("Wall_Growing"):
				$Snares_Of_Boss.get_children()[i].get_node("Wall_Growing").connect("area_entered", self, "_on_Wall_Growing_area_entered", [$Snares_Of_Boss.get_children()[i].get_node("Wall_Growing")])

	#Garsia1.position = $Positions_For_Enemies/Position_Garsia.global_position
	#self.add_child(Garsia1)
	$NavigationPolygonInstance2.set_enter_cost(2)


	if GLOBAL.first_cat_scene:
		$Position_Heroe.set_global_position(Vector2(2535, 1528))
	elif GLOBAL.position_heroe_before_fight != Vector2(0, 0):
		$Position_Heroe.set_global_position(GLOBAL.position_heroe_before_fight)
		GLOBAL.position_heroe_before_fight = Vector2(0, 0)

	if GLOBAL.first_cat_scene:
		$Positions_For_Enemies/Position_Belotur.set_global_position(Vector2(3535, 1528))

	if GLOBAL.first_cat_scene:
		$Positions_For_Enemies/Position_Adalard.set_global_position(Vector2(3535, 1528))
		
	if GLOBAL.first_cat_scene:
		$Positions_For_Enemies/Position_Jeison.set_global_position(Vector2(3530, 1528))

	heroe_1.position = $Position_Heroe.global_position
	if GLOBAL.name_of_dialoge_for_dialoge_field_scene != "":
		if GLOBAL.name_of_dialoge_for_dialoge_field_scene.split("-")[1] == self.get_name():
			heroe_1.modulate.a = 0
			self.add_child(heroe_1)
			heroe_1.get_node("AnimationPlayer").play("appearing")
			for i in range(get_node("Light_Objects").get_children().size()):
				get_node("Light_Objects").get_children()[i].variation_energy = 0
				get_node("Light_Objects").get_children()[i].fading = false
		else:
			self.add_child(heroe_1)
	else:
		self.add_child(heroe_1)
	
	for i in range(enemies.size()):
		self.add_child(enemies[i])
		if !GLOBAL.first_cat_scene:
			enemies[i].position = get_node("Positions_For_Enemies/Position_" + enemies[i].name_character).global_position
	
	"""if GLOBAL.life_Aglea == true:
		if !GLOBAL.first_cat_scene:
			enemy_1_1.position = $Positions_For_Enemies/Position_Aglea.global_position
		self.add_child(enemy_1_1)
	if !GLOBAL.died_enemies_at_first_level["Adalard"]:
		if !GLOBAL.first_cat_scene:
			enemy_1_2.position = $Positions_For_Enemies/Position_Adalard.global_position
		self.add_child(enemy_1_2)
	if !GLOBAL.died_enemies_at_first_level["Belotur"]:
		if !GLOBAL.first_cat_scene:
			enemy_1_3.position = $Positions_For_Enemies/Position_Belotur.global_position
		self.add_child(enemy_1_3)
	if GLOBAL.life_Akira == true:
		if !GLOBAL.first_cat_scene:
			enemy_1_4.position = $Positions_For_Enemies/Position_Akira.global_position
		self.add_child(enemy_1_4)
	if !GLOBAL.died_enemies_at_first_level["Jeison"]:
		if !GLOBAL.first_cat_scene:
			enemy_1_5.position = $Positions_For_Enemies/Position_Jeison.global_position
		self.add_child(enemy_1_5)"""
	door_1.position = $Position_Door.global_position
	self.add_child(door_1)
	GLOBAL.heroe_uploaded = true
	get_node("Garsia/Trigger_Area").set_monitoring(false)
	
func _physics_process(delta):
	##(triggered_enemies)
	##(get_node("Snares_Of_Boss/Area2D6/PositionsWalls"))
	##(GLOBAL.dialoge_No_heroe_camera)
	##(GLOBAL.dialoge_heroe_camera)
	##(get_node("Garsia").nav_path is String)
	$Line2D.set_points(get_node("Garsia").nav_path)
			
	#if GLOBAL.life_Belotur:
	#	if $Belotur.global_position == first_position_Belotur:
	#		Belotur_was_triggered = false
	#	if $Jeison.global_position == first_position_Jeison:
	#		Jeison_was_triggered = false
	#	if $Adalard.global_position == first_position_Adalard:
	#		Adalard_was_triggered = false
	
	
	if self.has_node("Heroe"):
		if $Heroe.in_invisibility && self.get_node("Bush").global_position.x - $Heroe.global_position.x < 33 && (self.get_node("Bush").global_position.x - $Heroe.global_position.x > -33):
			$Jeison.manual_navigation = true
			$Belotur.manual_navigation = true
			$Adalard.manual_navigation = true
			$Jeison.nav_path = [$Jeison.global_position, Vector2(2525, 1533), Vector2(2505, 1533), Vector2(1400, 1347), first_position_Jeison]
			$Belotur.nav_path = [$Belotur.global_position, Vector2(2325, 1533), Vector2(2505, 1533), first_position_Belotur]
		if $Heroe.in_invisibility && self.get_node("Bush2").global_position.x - $Heroe.global_position.x < 33 && (self.get_node("Bush2").global_position.x - $Heroe.global_position.x > -33):
				current_target_Adalard = Vector2(2231, 1400)
				current_target_Aglea = Vector2(2231, 1400)
				current_target_Akira = Vector2(2231, 1400)
				current_target_Belotur = Vector2(2231, 1400)
				current_target_Jeison = Vector2(2231, 1400)
		if $Heroe.in_invisibility && self.get_node("Bush3").global_position.x - $Heroe.global_position.x < 33 && (self.get_node("Bush3").global_position.x - $Heroe.global_position.x > -33):
				current_target_Adalard = Vector2(1347, 1111)
				current_target_Aglea = Vector2(1347, 1111)
				current_target_Akira = Vector2(1347, 1111)
				current_target_Belotur = Vector2(1347, 1111)
				current_target_Jeison = Vector2(1347, 1111)
		if !$Heroe.in_invisibility:
			current_target = $Heroe.global_position
		# Target to heroe determine in script for enemy in "trigger_area_enetering"
	
		
	#if !GLOBAL.first_cat_scene && GLOBAL.life_Belotur == true:
		#if (($Belotur.global_position.x) - $Heroe.global_position.x < 25) && (($Belotur.global_position.x) - $Heroe.global_position.x > -26) && (($Belotur.global_position.y) - $Heroe.global_position.y < 15) && (($Belotur.global_position.y) - $Heroe.global_position.y > -15):
			#GLOBAL.position_heroe_before_fight = $Heroe.global_position
			#GLOBAL.scene("Max_level_Fight_Scene")
	#if GLOBAL.first_cat_scene && GLOBAL.dialoge_heroe_camera == true:
	#	GLOBAL.dialoge_No_heroe_camera = true
	#	GLOBAL.dialoge_heroe_camera = false
	if has_node("Dialoge_Layer/Dialoge_Area_2"):
		if has_node("Aglea"):
			if GLOBAL.first_cat_scene && !self.has_node("Heroe") && get_node("Aglea").current_target != Vector2(2250, 1530):
				start_manual_moving(null, [self.get_node("Aglea"), self.get_node("Akira"), self.get_node("Adalard"), self.get_node("Belotur"), self.get_node("Jeison")], [[Vector2(2250, 1530)], [Vector2(2280, 1530)], [Vector2(2165, 1530), Vector2(2185, 1530)], [Vector2(2135, 1530), Vector2(2155, 1530)], [Vector2(2105, 1530), Vector2(2125, 1530)]], [false, false, false, false, false], null, [Vector2(2485, 1530), Vector2(2445, 1530), Vector2(2465, 1530), Vector2(2425, 1530), Vector2(2505, 1530)], [2.5, 2.5, 2.5, 2.5, 2.5])
				
				"""

	if GLOBAL.akira_dialoge_started && !stop_Akira_1D:
		$Akira.number_of_dialoge = 1
		$Akira.array_dialoge_flags = [4,6,8,12,14]
		stop_Akira_1D = true
	"""
	if !self.has_node("Akira") && !self.has_node("Aglea") && !self.has_node("Jeison") && !self.has_node("Adalard") && !self.has_node("Belotur") && !self.has_node("Heroe"):
		match GLOBAL.first_cat_scene:
			true: GLOBAL.scene("Temple_lvl")
		GLOBAL.first_cat_scene = false
		self.queue_free()

func _on_Wall_Growing_area_entered(area, area_which_was_triggered):
	if area.get_name() == "Area_For_Wall_Detecting":
		##(true)
		var position_for_wall = area_which_was_triggered.get_parent().get_node("PositionsWalls/Position2D2").global_position
		if abs(area_which_was_triggered.global_position.x - area_which_was_triggered.get_parent().get_node("PositionsWalls/Position2D").global_position.x) < abs(area_which_was_triggered.global_position.x - area_which_was_triggered.get_parent().get_node("PositionsWalls/Position2D2").global_position.x):
			position_for_wall = area_which_was_triggered.get_parent().get_node("PositionsWalls/Position2D").global_position
		get_node("Garsia").stone_wall(position_for_wall, false, area_which_was_triggered.get_parent().get_node("PositionsWalls"))
	
func start_manual_moving(body = null, array_of_characters = null, array_of_target_points = null, stay_triggered = null, area_which_was_triggered = null, initial_position = null, array_of_velocity = null):
	if body != null:
		if body.has_method("start_jump_heroe"):
			for i in range(array_of_characters.size()):
				array_of_characters[i] = get_node(array_of_characters[i])
				array_of_characters[i].animate("idle")
				if area_which_was_triggered != null:
					array_of_characters[i].area_from_which_manual_navigation_was_started = area_which_was_triggered
				if initial_position != null:
					array_of_characters[i].global_position = initial_position[i]
				self.triggered_enemies[array_of_characters[i].get_name()] = true
				array_of_characters[i].should_be_triggered_after_manual_navigation = stay_triggered[i]
				array_of_characters[i].current_target = array_of_target_points[i][0]
				array_of_characters[i].target_points_for_manual_navigation = array_of_target_points[i]
				array_of_characters[i].update_way()
				array_of_characters[i].target_points_for_manual_navigation.remove(0)
				array_of_characters[i].speed = array_of_velocity[i]
				array_of_characters[i].manual_navigation = true
				get_node("Areas_For_Moving/" + area_which_was_triggered).queue_free()
	else:
		for i in range(array_of_characters.size()):
			array_of_characters[i] = get_node(array_of_characters[i])
			if initial_position != null:
				array_of_characters[i].global_position = initial_position[i]
			self.triggered_enemies[array_of_characters[i].get_name()] = true
			array_of_characters[i].should_be_triggered_after_manual_navigation = stay_triggered[i]
			array_of_characters[i].current_target = array_of_target_points[i][0]
			array_of_characters[i].target_points_for_manual_navigation = array_of_target_points[i]
			array_of_characters[i].update_way()
			array_of_characters[i].target_points_for_manual_navigation.remove(0)
			array_of_characters[i].speed = array_of_velocity[i]
			array_of_characters[i].manual_navigation = true

	
func dialoge_start(body = null, dialoge_area_name = null, lock_interface = false, dialoge_between_scenes = false):
	var activated_camera
	for key in GLOBAL.cameras.keys():
		if GLOBAL.cameras[key] == true:
			activated_camera = key
			break
	activated_camera = "Heroe/CanvasLayer"
	if activated_camera != "Enemy_Camera":
		if get_node(activated_camera + "/Dialoge_Field").file.is_open():
			get_node("Heroe/CanvasLayer/Dialoge_Field").file.close()
		get_node(activated_camera + "/Dialoge_Field").current_scene = self
		get_node(activated_camera + "/Dialoge_Field").dialoge_name = dialoge_area_name
		get_node(activated_camera + "/Dialoge_Field").set_visible(true)
		get_node(activated_camera + "/Dialoge_Field").file.open("res://Dialoges/"+ self.get_name() + "/" + dialoge_area_name + ".txt", File.READ) 
		var k = str(get_node(activated_camera + "/Dialoge_Field").file.get_line())
		get_node(activated_camera + "/Dialoge_Field/Sprite").set_texture(load("res://Icons_For_Characters/" + k.split(":: ")[0] + ".jpg"))
		get_node(activated_camera + "/Dialoge_Field/RichTextLabel").set_text(k.split(":: ")[1])
		get_node(activated_camera + "/Dialoge_Field/RichTextLabel2").set_text(k.split(":: ")[0])
		get_node("Dialoge_Layer/" + dialoge_area_name).queue_free()


func dialoge_finished(dialoge_name):
	match dialoge_name:
		"Dialoge_Area_3":
			#LOCATIONS_PARAMETERS.locations["Garsia_Boss_Fight_Scene"]["characters_for_uploading"].merge(GLOBAL.died_enemies_at_first_level, true)
			start_manual_moving(null, ["Garsia"], [[Vector2(2450, 830), Vector2(2512, 927), Vector2(2160, 920), Vector2(1842, 996), Vector2(1600, 1109), Vector2(627, 1376)]], [true], null, [Vector2(1225, 800)], [2.5])
		"Dialoge_Area_2":
			start_manual_moving(null, ["Aglea", "Akira", "Adalard", "Belotur", "Jeison"], [[Vector2(3250, 1530)], [Vector2(3280, 1530)], [Vector2(1165, 1530)], [Vector2(1135, 1530)], [Vector2(1105, 1530)]], [false, false, false, false, false], null, null, [2.5, 2.5, 2.5, 2.5, 2.5])

func _on_Stop_Machine_body_entered(body):
	if body.has_method("enemy"):
		get_node("Stop_Machine/CollisionShape2D").set_disabled(true)
		#body.stop_machine = true


"""
func _on_NoSpeed_Area_body_entered(body):
	if body.has_method("enemy"):
		body.get_node("Timers/Timer_For_Stop_Machine").start()
		if $Heroe.global_position.y < get_node("Areas_For_Specifical_Controlling/No-Speed_Area").global_position.y:
			if body.get_node("RayCastHorizontal_For_Heroe").get_collider():
				if !body.get_node("RayCastHorizontal_For_Heroe").get_collider().has_method("Heroe"):
					body.speed = 0
					body.stop_machine = true

			else:
				body.speed = 0
				body.stop_machine = true
"""

func _on_Speed_Area_body_entered(body):
	if body.has_method("enemy"):
		body.speed = 2.5
		body.stop_machine = false



func _on_Area1_area_entered(area):
	if area.has_method("area_for_fight"):
		for m in range (7):
			if area.get_collision_layer_bit(m):
				in_area_for_artifical_intelligance_controlling_1[m] = 1
			$NPIUlt.set_navigation_layers(from_dex_to_bin(in_area_for_artifical_intelligance_controlling_1)) 



func _on_Area1_area_exited(area):
	if area.has_method("area_for_fight"):
		for m in range (7):
			if area.get_collision_layer_bit(m):
				in_area_for_artifical_intelligance_controlling_1[m] = 0
			$NPIUlt.set_navigation_layers(from_dex_to_bin(in_area_for_artifical_intelligance_controlling_1)) 


func _on_Area2_area_entered(area):
	if area.has_method("area_for_fight"):
		for m in range (7):
			if area.get_collision_layer_bit(m):
				in_area_for_artifical_intelligance_controlling_2[m] = 1
			$NPIUlt2.set_navigation_layers(from_dex_to_bin(in_area_for_artifical_intelligance_controlling_2)) 
			$NPIUlt3.set_navigation_layers(from_dex_to_bin(in_area_for_artifical_intelligance_controlling_3)) 


func _on_Area2_area_exited(area):
	if area.has_method("area_for_fight"):
		for m in range (7):
			if area.get_collision_layer_bit(m):
				in_area_for_artifical_intelligance_controlling_2[m] = 0
			$NPIUlt2.set_navigation_layers(from_dex_to_bin(in_area_for_artifical_intelligance_controlling_2)) 
			$NPIUlt3.set_navigation_layers(from_dex_to_bin(in_area_for_artifical_intelligance_controlling_3)) 


func _on_Area3_area_entered(area):
	if area.has_method("area_for_fight"):
		for m in range (7):
			if area.get_collision_layer_bit(m):
				in_area_for_artifical_intelligance_controlling_3[m] = 1
			$NPIUlt4.set_navigation_layers(from_dex_to_bin(in_area_for_artifical_intelligance_controlling_3)) 


func _on_Area3_area_exited(area):
	if area.has_method("area_for_fight"):
		for m in range (7):
			if area.get_collision_layer_bit(m):
				in_area_for_artifical_intelligance_controlling_3[m] = 0
			$NPIUlt4.set_navigation_layers(from_dex_to_bin(in_area_for_artifical_intelligance_controlling_3)) 


func _on_Area4_area_entered(area):
	if area.has_method("area_for_fight"):
		for m in range (7):
			if area.get_collision_layer_bit(m):
				in_area_for_artifical_intelligance_controlling_4[m] = 1
			$NPIUlt4.set_navigation_layers(from_dex_to_bin(in_area_for_artifical_intelligance_controlling_4)) 


func _on_Area4_area_exited(area):
	if area.has_method("area_for_fight"):
		for m in range (7):
			if area.get_collision_layer_bit(m):
				in_area_for_artifical_intelligance_controlling_4[m] = 0
			$NPIUlt4.set_navigation_layers(from_dex_to_bin(in_area_for_artifical_intelligance_controlling_4)) 

func from_dex_to_bin(array):
	var bin = 0
	for p in range(array.size() - 1):
		if array[p] == 1:
			bin = bin + pow(2,p)
	return(bin)



func _on_Area_For_Waiting_Garsia_body_entered(body):
	if body.get_name() == "Garsia":

		if abs(get_node("Garsia").global_position.x - get_node("Heroe").global_position.x) > 190:
			get_node("Garsia").special_physics_process_controlling = true
		get_node("Area_For_Waiting_Garsia").queue_free()



func _on_Area_For_Starting_Fight_body_entered(body):
	if body.get_name() == "Garsia":
		get_node("Garsia").special_physics_process_controlling = true
		get_node("Garsia").animate("idle")
		get_node("Garsia/Area_For_Starting_Fight").monitoring = true
