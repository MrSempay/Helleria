extends Node


var Attack = 1
var counter_of_phrase = 1
var counter = 0

var variable_1 
var variable_2 

var life_Belotur = true
var life_Aglea = true
var life_Akira = true
var life_Adalard = true
var life_Jeison = true
var stop = false
var stop_ghost = false
var continue_jump = false
var continue_jump_ghost = false
var spell_of_button
var counter_of_body_armor = 0
var time_out_of_body_seal = false


var stone = 2 


var counter_of_first_button = 0
var counter_of_second_button = 0
var counter_of_third_button = 0




var counter_of_bow = 0
var counter_of_stone = 0
var counter_of_hedgehod = 0


var arrow_amount = 7
var vector_of_moving = 1
var count_of_containment = 7
var move_vector_1 = Vector2(0, 0)
var move_vector_1_ghost = Vector2(0, 0)

var life_heroe = true
var heroe_uploaded = false
var position_heroe_before_fight = Vector2(0, 0)

var cameras = {
	"Heroe/CanvasLayer": true,
	"Camera_For_Speaking": false,
	"Enemy_Camera": false
}

var died_enemies_at_first_level = {
	"Jeison": false,
	"Adalard": false,
	"Belotur": false,
	"Garsia": false,
	"Akira": false,
	"Aglea": false
}

const position_for_died_enemies_at_Garsia_fight = {
	"Jeison": Vector2(906, 75),
	"Belotur": Vector2(914, 213),
	"Adalard": Vector2(906, 355)
}


var dialoge_heroe_camera = true
var dialoge_No_heroe_camera = false

var aglea_dialoge_started = false
var heroe_dialoge_started = false
var imaginary_heroe_dialoge_started = false
var akira_dialoge_started = false
var belotur_dialoge_started = false
var adalard_dialoge_started = false
var jeison_dialoge_started = false

var aglea_dialoge_finished = false
var heroe_dialoge_finished = false
var imaginary_heroe_dialoge_finished = false
var akira_dialoge_finished = false
var belotur_dialoge_finished = false
var adalard_dialoge_finished = false
var jeison_dialoge_finished = false


var first_cat_scene = false
var first_starting_temple_lvl = true

var enemy_for_fight = ""

var heroe_is_observe = false
var ibo = true


var name_of_dialoge_for_dialoge_field_scene = ""
var just_statment = false
func scene(name, dialoge_between_scenes = false):
	get_tree().get_current_scene().queue_free()
	if !dialoge_between_scenes:
		get_tree().change_scene("res://Game/LocationsLevels/"+name+".tscn")
		return
	else:
		name_of_dialoge_for_dialoge_field_scene = get_tree().get_current_scene().get_name() + "-" + name
		get_tree().change_scene("res://Game/Dialoge_Field.tscn")
		
	
func first_spell_changing(speed, armor=0):
	speed = speed * 0.5
	return speed
	
var file = File.new()

func save_game(main_scene):
	# for main scene:
	var data_save = {}
	data_save["scene"] = [main_scene.get_name(), main_scene.triggered_enemies]
	if main_scene.has_node("Light_Objects"):
		data_save["Light_Objects"] = []
		for i in range(main_scene.get_node("Light_Objects").get_children().size()):
			data_save["Light_Objects"].append(main_scene.get_node("Light_Objects").get_children()[i].get_node("AnimatedSprite").get_animation())
	if main_scene.has_node("Dialoge_Layer"):
		var i = 0
		data_save["Dialoge_Layer"] = []
		while i < main_scene.get_node("Dialoge_Layer").get_children().size():
			data_save["Dialoge_Layer"].append(main_scene.get_node("Dialoge_Layer").get_children()[i].get_name())
			i += 1
	
# Creating an array of dictionaries and array, first dictionary consist parameters of wave, next one
# or two dictionaries consist information about walls, last array - one bool parameter of snare.
	if main_scene.has_node("Snares_Of_Boss"):
		#[[{wave parameters}, {Vector2, String}, {Vector2, String}, [bool]], [{wave parameters}, {Vector2, String}, {Vector2, String}, [bool]], ... ]
		var i = 0
		data_save["Snares_Of_Boss"] = []
		while i < main_scene.get_node("Snares_Of_Boss").get_children().size():
			var j = 0
			data_save["Snares_Of_Boss"].append([])
			if main_scene.get_node("Snares_Of_Boss").get_children()[i].get_node("For_Waves").get_children().size() > 0:
				while j < main_scene.get_node("Snares_Of_Boss").get_children()[i].get_node("For_Waves").get_children().size():
					data_save["Snares_Of_Boss"][i].append(main_scene.get_node("Snares_Of_Boss").get_children()[i].get_node("For_Waves").get_children()[j].local_parameters)
					j += 1
			j = 0
			while j < main_scene.get_node("Snares_Of_Boss").get_children()[i].get_node("PositionsWalls").get_children().size():
				if main_scene.get_node("Snares_Of_Boss").get_children()[i].get_node("PositionsWalls").get_children()[j].get_name()[0] == "S":
					data_save["Snares_Of_Boss"][i].append({
						"global_position": main_scene.get_node("Snares_Of_Boss").get_children()[i].get_node("PositionsWalls").get_children()[j].global_position,
						"first_anim":  main_scene.get_node("Snares_Of_Boss").get_children()[i].get_node("PositionsWalls").get_children()[j].first_anim
					})
				j += 1
			data_save["Snares_Of_Boss"][i].append([main_scene.get_node("Snares_Of_Boss").get_children()[i].is_monitoring()])
			i += 1
		data_save["Enemies"] = []
		if main_scene.enemies.size() > 0:
			for k in range(main_scene.enemies.size()):
				if is_instance_valid(main_scene.enemies[k]):
					data_save["Enemies"].append(
							{
								"name_character": main_scene.enemies[k].name_character,
								"nav_path": Array(main_scene.enemies[k].nav_path),
								"target_points_for_manual_navigation": main_scene.enemies[k].target_points_for_manual_navigation,
								"should_be_triggered_after_manual_navigation": main_scene.enemies[k].should_be_triggered_after_manual_navigation,
								"area_from_which_manual_navigation_was_started": main_scene.enemies[k].area_from_which_manual_navigation_was_started,
								"manual_navigation": main_scene.enemies[k].manual_navigation,
								"current_target": main_scene.enemies[k].current_target,
								"health": main_scene.enemies[k].health,
								"mana": main_scene.enemies[k].mana,
								"auto_manual_navigation": main_scene.enemies[k].auto_manual_navigation,
								"scale_speed_moving": main_scene.enemies[k].scale_speed_moving,
								"speed": main_scene.enemies[k].speed,
								"stop_machine": main_scene.enemies[k].stop_machine,
								"position": main_scene.enemies[k].position
							}
					)
	data_save["GLOBAL"] = {
		"life_heroe": life_heroe,
		"position_heroe_before_fight": position_heroe_before_fight,
		"cameras": cameras,
		"died_enemies_at_first_level": died_enemies_at_first_level,
		"first_cat_scene": first_cat_scene,
		"first_starting_temple_lvl": first_starting_temple_lvl,
		"enemy_for_fight": enemy_for_fight
	}
	

	
	if main_scene.has_node("Heroe"):
		data_save["Heroe"] = {
			"health": main_scene.get_node("Heroe").health,
			"speed": main_scene.get_node("Heroe").speed,
			"position": main_scene.get_node("Heroe").position,
			"scale_speed_moving": main_scene.get_node("Heroe").scale_speed_moving,
			"in_invisibility": main_scene.get_node("Heroe").in_invisibility,
			"velocity": main_scene.get_node("Heroe").velocity
		}
		
	file.open("user://hellaria.txt", File.WRITE_READ)
	##(data_save)
	file.store_var(to_json(data_save))
	#(file.get_path_absolute())
	file.close()

func load_game():
	file.open("user://hellaria.txt", File.READ)
	var loaded_data = JSON.parse(file.get_var()).get_result()
	loaded_data = check_type_for_detectingVector2(loaded_data)
	##(loaded_data["Enemies"]["Belotur"])
	#for i in range(loaded_data["Enemies"].size()):
	#	for key in loaded_data["Enemies"][i].keys():
	#		if key == "speed":
	#			#(typeof(loaded_data["Enemies"][i][key]))
	file.close()
	for key in loaded_data["GLOBAL"].keys():
		set(key, loaded_data["GLOBAL"][key])
	##(loaded_data["Snares_Of_Boss"])
	GLOBAL.scene(loaded_data["scene"][0])
	yield(get_tree(), "idle_frame")
	var main_scene = get_tree().get_current_scene()
	main_scene.triggered_enemies = loaded_data["scene"][1]
	if main_scene.has_node("Light_Objects"):
		for i in range(main_scene.get_node("Light_Objects").get_children().size()):
			main_scene.get_node("Light_Objects").get_children()[i].get_node("AnimatedSprite").set_animation(loaded_data["Light_Objects"][i])
	if main_scene.has_node("Dialoge_Layer"):
		var i = 0
		while i < main_scene.get_node("Dialoge_Layer").get_children().size():
			if !loaded_data["Dialoge_Layer"].has(main_scene.get_node("Dialoge_Layer").get_children()[i].get_name()):
				main_scene.get_node("Dialoge_Layer").get_children()[i].queue_free()
			i += 1
	if main_scene.has_node("Snares_Of_Boss"):
		var i = 0
		while i < main_scene.get_node("Snares_Of_Boss").get_children().size():
			var j = 0
			while j < main_scene.get_node("Snares_Of_Boss").get_children()[i].get_node("PositionsWalls").get_children().size():
				if main_scene.get_node("Snares_Of_Boss").get_children()[i].get_node("PositionsWalls").get_children()[j].get_name()[0] == "S":
					main_scene.get_node("Snares_Of_Boss").get_children()[i].get_node("PositionsWalls").get_children()[j].queue_free()
				j += 1
			j = 0
			while j < loaded_data["Snares_Of_Boss"][i].size():
				if loaded_data["Snares_Of_Boss"][i][j].size() > 5:
					var wave = preload("res://Game/Spells/Wave.tscn").instance()
					wave.local_parameters = loaded_data["Snares_Of_Boss"][i][0]
					main_scene.get_node("Snares_Of_Boss/" + main_scene.get_node("Snares_Of_Boss").get_children()[i].get_name() + "/For_Waves").add_child(wave)
				if loaded_data["Snares_Of_Boss"][i][j].size() == 2:
					var stone_wall = preload("res://Game/Tile_setsTools_for_level/Tools_for_level/Stone_Wall.tscn").instance()
					stone_wall.name = "Stone_Wall" + str(randi())
					main_scene.get_node("Snares_Of_Boss/" + main_scene.get_node("Snares_Of_Boss").get_children()[i].get_name() + "/PositionsWalls").add_child(stone_wall)
					stone_wall.global_position = loaded_data["Snares_Of_Boss"][i][j]["global_position"]
					stone_wall.first_anim = loaded_data["Snares_Of_Boss"][i][j]["first_anim"]
				if loaded_data["Snares_Of_Boss"][i][loaded_data["Snares_Of_Boss"][i].size() - 1][0] == false:
					main_scene.get_node("Snares_Of_Boss").get_children()[i].set_monitoring(false)
					main_scene.get_node("Garsia").creating_timer_for_calldown_snare(main_scene.get_node("Snares_Of_Boss").get_children()[i])
				j += 1
			i += 1
	if loaded_data.has("Enemies"):
		for i in range(loaded_data["Enemies"].size()):
			for key in loaded_data["Enemies"][i].keys():
				main_scene.get_node(loaded_data["Enemies"][i]["name_character"]).set(key, loaded_data["Enemies"][i][key])
	if loaded_data.has("Heroe"):
		for key in loaded_data["Heroe"].keys():
			main_scene.get_node("Heroe").set(key, loaded_data["Heroe"][key])
	
	
	
#add_menu - ALWAYS, Even if you wish to unpause game.
func pause_or_unpause_game(main_scene, pause, add_menu):
	main_scene.set_physics_process(!pause)
	go_through_all_nodes_from_the_given_node(main_scene, pause)
	for i in range(main_scene.get_children().size()):
		#main_scene.get_children()[i].set_physics_process(!pause)
		if pause:
			if main_scene.get_children()[i].has_node("Sprite"):
				if main_scene.get_children()[i].get_node("Sprite").get_class() == "AnimatedSprite":
					main_scene.get_children()[i].get_node("Sprite").stop()
			if main_scene.get_children()[i].has_node("AnimatedSprite"): 
				main_scene.get_children()[i].get_node("AnimatedSprite").stop()
		else:
			if main_scene.get_children()[i].has_node("Sprite"):
				if main_scene.get_children()[i].get_node("Sprite").get_class() == "AnimatedSprite":
					main_scene.get_children()[i].get_node("Sprite").play()
			if main_scene.get_children()[i].has_node("AnimatedSprite"): 
				main_scene.get_children()[i].get_node("AnimatedSprite").play()
		if main_scene.get_children()[i].has_node("Timers"):
		#	for j in range(main_scene.get_children()[i].get_node("Timers").get_children().size()):
		#		main_scene.get_children()[i].get_node("Timers").get_children()[j].set_paused(pause)
			for j in range(main_scene.get_children()[i].get_node("For_Status_Bars").get_children().size()):
				main_scene.get_children()[i].get_node("For_Status_Bars").get_children()[j].get_node("Timer").set_paused(pause)
	if main_scene.has_node("Timers"):
		for i in range(main_scene.get_node("Timers").get_children().size()):
			main_scene.get_node("Timers").get_children()[i].set_paused(pause)
	if main_scene.has_node("Heroe"):
		for i in range(main_scene.get_node("Heroe/Buttons_Of_Heroe").get_children().size()):
			if main_scene.get_node("Heroe/Buttons_Of_Heroe").get_children()[i].get_class() == "Button":
				main_scene.get_node("Heroe/Buttons_Of_Heroe").get_children()[i].set_disabled(pause)
		if add_menu:
			if pause:
				main_scene.get_node("Heroe/Icon").stop()
				var local_menu = preload("res://Game/Local_Menu.tscn").instance()
				local_menu.set_position(Vector2(-30,-77))
				main_scene.get_node("Heroe").add_child(local_menu)
			else: 
				main_scene.get_node("Heroe/Icon").play()
				if main_scene.has_node("Heroe/Local_Menu"):
					main_scene.get_node("Heroe/Local_Menu").queue_free()

	
func check_type_for_detectingVector2(value):
	if typeof(value) == TYPE_ARRAY:
		for i in range(value.size()):
			value[i] = check_type_for_detectingVector2(value[i])
	elif typeof(value) == TYPE_DICTIONARY:
		for key in value.keys():
			value[key] = check_type_for_detectingVector2(value[key])
	else:
		if typeof(value) == TYPE_STRING:
			if value.split(",").size() == 2:
				if value[0] == "(" && value[value.length() - 1] == ")":
					value.erase(0, 1)
					value.erase(value.length() - 1, 1)
					var array: Array = value.split(", ")
					return Vector2(array[0], array[1])
	return value

func go_through_all_nodes_from_the_given_node(node, pause_them = null):
	for N in node.get_children():
		if pause_them != null:
			if N is Timer:
				N.set_paused(pause_them)
			N.set_physics_process(!pause_them)
			N.set_process_input(!pause_them)
			if N is AnimatedSprite:
				if !(N.get_sprite_frames().get_animation_names().has("torchOn") or N.get_sprite_frames().get_animation_names().has("growing")):
					N.set_playing(!pause_them)
		if N.get_child_count() > 0:
			go_through_all_nodes_from_the_given_node(N, pause_them)
	
func get_segments_from_CollisionShape_or_collisionPolygon(area):
	var array_of_segments = []
	var shape = area.get_children()[0]
	var shape_classname = shape.get_class()
	var array_points = []
	match shape_classname:
		"CollisionPolygon2D":
			for i in range(shape.polygon.size()):
				if i == shape.polygon.size() - 1:
					array_of_segments.append([shape.polygon[i] + area.global_position, shape.polygon[0] + area.global_position])
					return array_of_segments
				array_of_segments.append([shape.polygon[i] + area.global_position, shape.polygon[i + 1] + area.global_position])
		"CollisionShape2D":
			array_points.append(Vector2(area.global_position.x - shape.shape.extents.x, area.global_position.y - shape.shape.extents.y))
			array_points.append(Vector2(area.global_position.x + shape.shape.extents.x, area.global_position.y - shape.shape.extents.y))
			array_points.append(Vector2(area.global_position.x + shape.shape.extents.x, area.global_position.y + shape.shape.extents.y))
			array_points.append(Vector2(area.global_position.x - shape.shape.extents.x, area.global_position.y + shape.shape.extents.y))
			for i in range(array_points.size()):
				if i == array_points.size() - 1:
					array_of_segments.append([array_points[i], array_points[0]])
					return array_of_segments
				array_of_segments.append([array_points[i], array_points[i + 1]])

		




func intersecting_vectors(mass_segment1, mass_segment2):
	var t
	var s
	var A = Vector2.ZERO
	var B = Vector2.ZERO
	var C = Vector2.ZERO
	var D = Vector2.ZERO
	var is_intersection = false
	for i in range(mass_segment1.size()):
		A.x = mass_segment1[i][0].x
		A.y = mass_segment1[i][0].y
		B.x = mass_segment1[i][1].x
		B.y = mass_segment1[i][1].y
		for j in range(mass_segment2.size()):
			C.x = mass_segment2[j][0].x
			C.y = mass_segment2[j][0].y
			D.x = mass_segment2[j][1].x
			D.y = mass_segment2[j][1].y
			if ((B.x - A.x) * (D.y - C.y) == (B.y - A.y) * (D.x - C.x)):
				pass
			else:
				t = ((C.x - A.x) * (D.y - C.y) - (C.y - A.y) * (D.x - C.x)) / ((B.x - A.x) * (D.y - C.y) - (B.y - A.y) * (D.x - C.x))
				s = (A.x + t * (B.x - A.x) - C.x)/(D.x + 0.0001 - C.x)
				if s >= 0 && s <= 1 && t >= 0 && t <= 1:
					return true
	return false



func making_animation_for_sprite_from_folder(path, sprite, anim_name, animation_loop = false, sprite_position = Vector2(0, 0), fps = 5, start_animation_after_completing = true):
	var dir_animation = Directory.new()
	if dir_animation.open(path) == OK:
		##(anim_name)
		##(sprite.get_sprite_frames().get_animation_names())
		dir_animation.list_dir_begin(true)
		var animation_frame = dir_animation.get_next()
		if sprite.get_sprite_frames() == null:
			sprite.set_sprite_frames(SpriteFrames.new())
		sprite.get_sprite_frames().add_animation(anim_name)
		sprite.get_sprite_frames().set_animation_loop(anim_name, animation_loop)
		sprite.set_position(sprite_position)
		sprite.get_sprite_frames().set_animation_speed(anim_name, fps)
		sprite.scale = Vector2(2, 2)
		while animation_frame != "":
			if not animation_frame.ends_with(".import"):
				##(animation_frame)
				sprite.get_sprite_frames().add_frame(anim_name, load(path + "/" + animation_frame))
			animation_frame = dir_animation.get_next()
	if start_animation_after_completing:
		sprite.play(anim_name)
	return sprite

#shell
#add symbol after given one
#Get-ChildItem 'C:\Your\Folder\Path' | ForEach-Object { Rename-Item $_.FullName ($_.Name.Replace('yourOldChar', 'yourOldChar' + 'yourNewChar')) }

#add symbol after given one if between symbol and character "." is placed only one symbol
#Get-ChildItem 'C:\Your\Folder\Path' | ForEach-Object {
#    if ($_.Name -match '1.{1}\.') {
#        $newName = $_.Name -replace '1(.)\.', '1_$1.'
#        Rename-Item $_.FullName -NewName $newName
#    }
#}
