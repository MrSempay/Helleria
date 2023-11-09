extends Node2D

var triggered_enemies = {}
var enemies = []                #будет массив ОБЪЕКТОВ
var heroe = preload("res://Game/Characters/Heroe.tscn")
var heroe1

	#for key in GLOBAL.cameras.keys():
	#	if GLOBAL.cameras[key] == true:
	#		activated_camera = key
	#		break

func _ready():
	
	heroe1 = heroe.instance()
	heroe1.position = $Position_Heroe.global_position
	self.add_child(heroe1)
	var j = 0
	triggered_enemies = LOCATIONS_PARAMETERS.locations[self.get_name()]["characters_for_uploading"]
	for key in LOCATIONS_PARAMETERS.locations[self.get_name()]["characters_for_uploading"].keys():
		var enemy = load("res://Game/Characters/" + key + ".tscn")
		enemies.append(enemy.instance())
		enemies[j].position = get_node("Positions_For_Enemies/Position_" + key).global_position
		enemies[j].set_collision_layer(0)
		enemies[j].set_collision_mask(0)
		enemies[j].set_collision_layer_bit(j + 2, true)
		enemies[j].set_collision_mask_bit(j + 2, true)
		self.add_child(enemies[j])
		j += 1
	
	if self.has_node("Dialoge_Layer"):
		for i in range($Dialoge_Layer.get_children().size()):
			$Dialoge_Layer.get_children()[i].connect("body_entered", self, "dialoge_start", [$Dialoge_Layer.get_children()[i].get_name()])
	if self.has_node("Areas_For_Moving"):
		for i in range($Areas_For_Moving.get_children().size()):
			$Areas_For_Moving.get_children()[i].connect("body_entered", self, "start_manual_moving", LOCATIONS_PARAMETERS.locations[self.get_name()]["Areas_For_Moving"][$Areas_For_Moving.get_children()[i].get_name()])
	if self.has_node("Areas_For_Specifical_Controlling"):
		for i in range($Areas_For_Specifical_Controlling.get_children().size()):
			$Areas_For_Specifical_Controlling.get_children()[i].connect("area_entered", self, "_on_Area_Stop_Moving_area_entered")
	if GLOBAL.name_of_dialoge_for_dialoge_field_scene != "":
		if GLOBAL.name_of_dialoge_for_dialoge_field_scene.split("-")[1] == self.get_name():
			heroe1.modulate.a = 0
			self.add_child(heroe1)
			heroe1.get_node("AnimationPlayer").play("appearing")
			if has_node("Light_Objects"):
				for i in range(get_node("Light_Objects").get_children().size()):
					get_node("Light_Objects").get_children()[i].variation_energy = 0
					get_node("Light_Objects").get_children()[i].fading = false
		else:
			self.add_child(heroe1)
	else:
		self.add_child(heroe1)
		
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
	
# As I understand this function can be used for starting jump between scene with using dialogue scene amid.
# Have to admit, that function calls manualy or when you enter in area.
# If call manualy
func dialoge_start(body = null, dialoge_area_name = null, dialoge_between_scenesNameTargetScene = null):
	var right_body = false
	if body != null:
		if body.has_method("start_jump_heroe") or body.has_method("enemy"):
			right_body = true
	if body == null or right_body:
		if dialoge_between_scenesNameTargetScene != null:
			start_transition_between_scenes_with_dialogue()
			return
		var activated_camera
		for key in GLOBAL.cameras.keys():
			if GLOBAL.cameras[key] == true:
				activated_camera = key
				break
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

func start_transition_between_scenes_with_dialogue():
	get_node("Heroe").create_animation_for_disappearing()
	get_node("Heroe/AnimationPlayer").play("disappearing")
	get_node("Heroe").stun = true
	for i in range(enemies.size()):
		if is_instance_valid(enemies[i]):
			enemies[i].stun = true
			enemies[i].animate("idle")
	for i in range(get_node("Light_Objects").get_children().size()):
		get_node("Light_Objects").get_children()[i].fading = true
	var timer = Timer.new()
	add_child(timer)
	timer.wait_time = 2.5
	timer.one_shot = true
	timer.connect("timeout", self, "_on_timer_for_start_changing_scene_to_dialoge_timeout", [timer, GLOBAL.name_of_dialoge_for_dialoge_field_scene.split("-")[0]])
	timer.start()

func _on_Area_Stop_Moving_area_entered(area):
	if area.get_name() == "AreaOfEnemy":
		area.get_parent().speed = 0
		area.get_parent().stop_machine = true
		if !area.get_parent().has_node("TimerStartMoving"):
			var timer_start_moving = Timer.new()
			timer_start_moving.set_wait_time(0.5)
			timer_start_moving.name = "TimerStartMoving"
			timer_start_moving.connect("timeout", self, "_on_timer_for_start_moving_timeout", [area, timer_start_moving])
			timer_start_moving.one_shot = true
			self.add_child(timer_start_moving)
			timer_start_moving.start()
		else:
			area.get_parent().get_node("TimerStartMoving").start()
		
func _on_timer_for_start_moving_timeout(area, timer):
	area.get_parent().speed = 2.5
	area.get_parent().stop_machine = false

func _on_timer_for_start_changing_scene_to_dialoge_timeout(timer, target_scene):
	GLOBAL.scene(target_scene, true)
	timer.queue_free()
	
func changing_scene_if_enemies_die(name_character):
	if has_method("Fight_Scene"):
		for key in LOCATIONS_PARAMETERS.locations[self.get_name()]["characters_for_uploading"]:
			if has_node(key) && key != name_character:
				return
		start_transition_between_scenes_with_dialogue()
	
