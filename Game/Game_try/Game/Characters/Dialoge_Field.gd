extends TouchScreenButton

var current_scene
var dialoge_name
var mouse_in_area = false
var file = File.new()
var can_press = true

# Called when the node enters the scene tree for the first time.
func _ready():
	if get_parent().get_name() != "root":
		get_parent().get_parent().connect("dialoge_started", self, "dialoge_start")
	else:
		modulate = Color(0.0, 0.0, 0.0, 1.0)
		dialoge_name = GLOBAL.name_of_dialoge_for_dialoge_field_scene
		current_scene = GLOBAL.name_of_dialoge_for_dialoge_field_scene.split("-")[0]
		if file.open("res://Dialoges/" + current_scene + "/" + dialoge_name + ".txt", File.READ) == 7:
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
		get_viewport().connect("size_changed",self,"resiz1e")
		set_visible(true)
		#file.open("res://Dialoges/" + current_scene + "/" + dialoge_name + ".txt", File.READ) 
		var k = str(file.get_line())
		get_node("Sprite").set_texture(load("res://Icons_For_Characters/" + k.split(":: ")[0] + ".jpg"))
		get_node("RichTextLabel").set_text(k.split(":: ")[1])
		get_node("RichTextLabel2").set_text(k.split(":: ")[0])
		print(modulate.a)



func dialoge_start(file_name, file):
	pass


func _on_Dialoge_Field_pressed():
	if can_press == true:
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
			current_scene.dialoge_finished(dialoge_name)
		mouse_in_area = true
		can_press = false

func _on_Dialoge_Field_released():
	can_press = true
	
func resiz1e():
	var resolution_x = get_viewport().size.x
	var amendment_y = 0
	if get_viewport().size.x/get_viewport().size.y > 1.83:
		amendment_y = 15 * get_viewport().size.x/get_viewport().size.y * 4
	self.scale = Vector2(3 * resolution_x/1024, 3 * resolution_x/1024)
	position = Vector2(252, 441 - amendment_y) * resolution_x/1024
