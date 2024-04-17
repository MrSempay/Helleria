extends TouchScreenButton

var current_scene = null
var dialoge_name
var mouse_in_area = false
var file = File.new()
var file_for_choice = File.new()
var can_press = true
var self_y = 441
var self_scale = 3

var information_about_current_dialogue_tree = {
	"must_choose": false,
	#"index_of_choice": 1,
	"dialogue_name": "",
	"index_of_depth_dialogue": 2,
	"path_to_dialogue_folder": ""
}


func _physics_process(delta):
	print(information_about_current_dialogue_tree["dialogue_name"])
	print(get_parent().get_parent())

# Called when the node enters the scene tree for the first time.
func _ready():
	get_viewport().connect("size_changed",self,"resiz1e")
	if GLOBAL.just_statment:
		$Sprite.visible = false
		$RichTextLabel2.visible = false
		position.y = position.y - position.y * 0.5
		self_y = position.y
		scale.y = 5
		self_scale = 5
		$RichTextLabel.set_scale(Vector2(0.4, 0.25))
		$RichTextLabel.set_position(Vector2(2, 3))
		$RichTextLabel.set_size(Vector2(445, 85))
		$RichTextLabel.set_text("ibovdifj i fsifjhsp ifhjsdpif hsdpif hsdpif hsdpif hsdpif sdpif sdpi f")
		return
	if get_parent().get_name() != "root":
		get_parent().get_parent().connect("dialoge_started", self, "dialoge_start")
	elif GLOBAL.name_of_dialoge_for_dialoge_field_scene != "":
		modulate = Color(0.0, 0.0, 0.0, 1.0)
		dialoge_name = GLOBAL.name_of_dialoge_for_dialoge_field_scene
		current_scene = GLOBAL.name_of_dialoge_for_dialoge_field_scene.split("-")[0]
		if file.open("res://Dialoges/"+ current_scene + "/" + dialoge_name + "/Text_D/" + information_about_current_dialogue_tree["dialogue_name"] + "/" + information_about_current_dialogue_tree["dialogue_name"] + ".txt", File.READ) == 7:
			GLOBAL.scene(GLOBAL.name_of_dialoge_for_dialoge_field_scene.split("-")[1], false)
			queue_free()
			return
		modulate = Color(1.0, 1.0, 1.0, 1.0)
		var resolution_x = get_viewport().size.x
		var amendment_y = 0
		if get_viewport().size.x/get_viewport().size.y > 1.83:
			amendment_y = 15 * get_viewport().size.x/get_viewport().size.y * 4
		self.scale = Vector2(3 * resolution_x/1024, 3 * resolution_x/1024)
		position = Vector2(252, 441 - amendment_y) * resolution_x/1024
		set_visible(true)
		#file.open("res://Dialoges/" + current_scene + "/" + dialoge_name + ".txt", File.READ) 
		var k = str(file.get_line())
		get_node("Sprite").set_texture(load("res://Icons_For_Characters/" + k.split(":: ")[0] + ".jpg"))
		get_node("RichTextLabel").set_text(k.split(":: ")[1])
		get_node("RichTextLabel2").set_text(k.split(":: ")[0])



func dialoge_start(file_name, file):
	
	pass

# && GLOBAL.name_of_dialoge_for_dialoge_field_scene != ""
func _on_Dialoge_Field_pressed():
	if can_press == true && !GLOBAL.just_statment && !information_about_current_dialogue_tree["must_choose"]:
		var k = str(file.get_line())
		$Sprite.set_texture(load("res://Icons_For_Characters/" + k.split(":: ")[0] + ".jpg"))
		if k != "":
			$RichTextLabel.set_text(k.split(":: ")[1])
			$RichTextLabel2.set_text(k.split(":: ")[0])
		else:
			if get_parent().get_name() == "root":
				GLOBAL.scene(GLOBAL.name_of_dialoge_for_dialoge_field_scene.split("-")[1], false)
				queue_free()
				return
			self.set_visible(false)
			file.close()
			#(current_scene)
			current_scene.dialoge_finished(dialoge_name)
		mouse_in_area = true
		can_press = false
	if GLOBAL.just_statment:
		GLOBAL.scene(GLOBAL.name_of_dialoge_for_dialoge_field_scene.split("-")[1], false)
		GLOBAL.just_statment = false
		queue_free()

func _on_Dialoge_Field_released():
	can_press = true
	
	
func resiz1e():
	if get_parent().get_name() == "root":
		var resolution_x = get_viewport().size.x
		var amendment_y = 0
		if get_viewport().size.x/get_viewport().size.y > 1.83:
			amendment_y = 15 * get_viewport().size.x/get_viewport().size.y * 4
		self.scale = Vector2(3 * resolution_x/1024, self_scale * resolution_x/1024)
		position = Vector2(252, self_y - amendment_y) * resolution_x/1024
		
func _on_buttons_for_choice_pressed(button):
	#print("???")
	#print(information_about_current_dialogue_tree)
	#information_about_current_dialogue_tree["index_of_choice"] = button.get_text()[0]
	#(button.get_text()[0])
	##(information_about_current_dialogue_tree["dialogue_name"])
	print(information_about_current_dialogue_tree["dialogue_name"])
	information_about_current_dialogue_tree["dialogue_name"] = information_about_current_dialogue_tree["dialogue_name"].left(information_about_current_dialogue_tree["index_of_depth_dialogue"]) + button.get_text()[0] + information_about_current_dialogue_tree["dialogue_name"].right(information_about_current_dialogue_tree["index_of_depth_dialogue"] + 1)
	print(information_about_current_dialogue_tree["dialogue_name"])

	information_about_current_dialogue_tree["index_of_depth_dialogue"] += 2
	var dir_of_next_dialogue = Directory.new()
	##(information_about_current_dialogue_tree["path_to_dialogue_folder"] + "/" + information_about_current_dialogue_tree["dialogue_name"])
	if dir_of_next_dialogue.open(information_about_current_dialogue_tree["path_to_dialogue_folder"] + "/" + information_about_current_dialogue_tree["dialogue_name"]) == OK:
		print("MDA")
		file.close()
		#(information_about_current_dialogue_tree["path_to_dialogue_folder"] + "/" + information_about_current_dialogue_tree["dialogue_name"] + "/" +  information_about_current_dialogue_tree["dialogue_name"] + ".txt")
		if file.open(information_about_current_dialogue_tree["path_to_dialogue_folder"] + "/" + information_about_current_dialogue_tree["dialogue_name"] + "/" +  information_about_current_dialogue_tree["dialogue_name"] + ".txt", File.READ) == OK:
			var k = str(file.get_line())
			$Sprite.set_texture(load("res://Icons_For_Characters/" + k.split(":: ")[0] + ".jpg"))
			$RichTextLabel.set_text(k.split(":: ")[1])
			$RichTextLabel2.set_text(k.split(":: ")[0])
			file_for_choice.close()
			if file_for_choice.open(information_about_current_dialogue_tree["path_to_dialogue_folder"] + "/" + information_about_current_dialogue_tree["dialogue_name"] + "/" + "Choice.txt", File.READ) == OK:
				information_about_current_dialogue_tree["must_choose"] = true
				for i in range ($ButtonsForChoice.get_children().size()):
					remove_child($ButtonsForChoice.get_children()[i])
					$ButtonsForChoice.get_children()[i].queue_free()
				var m = "none"
				while m != "":
					m = str(file_for_choice.get_line())
					if m != "":
						var button1 = Button.new()
						button1.connect("pressed", self, "_on_buttons_for_choice_pressed", [button1])
						$ButtonsForChoice.add_child(button1)
						button1.set_text(m)
			else:
				information_about_current_dialogue_tree["must_choose"] = false
			information_about_current_dialogue_tree["path_to_dialogue_folder"] = information_about_current_dialogue_tree["path_to_dialogue_folder"] + "/" + information_about_current_dialogue_tree["dialogue_name"]
	else:
		information_about_current_dialogue_tree["must_choose"] = false
		for i in range ($ButtonsForChoice.get_children().size()):
			remove_child($ButtonsForChoice.get_children()[i])
			$ButtonsForChoice.get_children()[i].queue_free()
