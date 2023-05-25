extends TouchScreenButton


var mouse_in_area = false
var file = File.new()
var b = "taaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaakkkkkkkkaaaaaaaaaaaaaaaaaaaext"
var can_press = true

# Called when the node enters the scene tree for the first time.
func _ready():
	get_parent().get_parent().connect("dialoge_started", self, "dialoge_start")

	
func dialoge_start(file_name, file):
	pass
	#print(true)
	#file.open("res://" + file_name + ".txt", File.READ)
	#self.set_visible(true)
	#var k = str(file.get_line())
	#$RichTextLabel.set_text(k.split(": ")[1])
"""
func _input(event):
	print(mouse_in_area)
	if event is InputEventScreenTouch and event.is_pressed() && (GLOBAL.dialoge_heroe_camera or GLOBAL.dialoge_No_heroe_camera) && mouse_in_area:
		var k = str(file.get_line())
		if k != "":
			$RichTextLabel.set_text(k.split(": ")[1])
		else:
			self.set_visible(false)
			file.close()
			GLOBAL.dialoge_heroe_camera = false
			GLOBAL.dialoge_No_heroe_camera = false


func _on_Area2D_mouse_entered():
	mouse_in_area = true


func _on_Area2D_mouse_exited():
	print("ibo")
	mouse_in_area = false
"""

func _on_Dialoge_Field_pressed():
	if can_press == true:
		var k = str(file.get_line())
		$Sprite.set_texture(load("res://Icons_For_Characters/" + k.split(":: ")[0] + ".jpg"))
		if k != "":
			$RichTextLabel.set_text(k.split(":: ")[1])
			$RichTextLabel2.set_text(k.split(":: ")[0])
		else:
			self.set_visible(false)
			file.close()
			GLOBAL.dialoge_heroe_camera = false
			GLOBAL.dialoge_No_heroe_camera = false
		mouse_in_area = true
		can_press = false

func _on_Dialoge_Field_released():
	can_press = true
