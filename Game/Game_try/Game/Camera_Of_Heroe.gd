extends Camera2D

var resolution_x
var camera_scale

func _ready():
	
	#if get_viewport().size.x/get_viewport().size.y > 1.76:
	#	get_parent().get_node("CanvasLayer").set_position(Vector2(-108, -15 * 1 + (get_viewport().size.x/get_viewport().size.y - 1.76)))
	
	#get_parent().get_node("RichTextLabel").set_text(str(get_viewport()))
	#get_parent().get_node("RichTextLabel2").set_text(str(get_viewport().size))
	
	if get_viewport().size.x/get_viewport().size.y > 1.76:
		get_parent().get_node("CanvasLayer").set_position(Vector2(-108, -15 * (1 + (get_viewport().size.x/get_viewport().size.y - 1.76) * 2)))
		get_parent().get_node("Jumping_Button").set_position(Vector2(89, -16 * (1 + (get_viewport().size.x/get_viewport().size.y - 1.76) * 2)))
		get_parent().get_node("Buttons_Of_Heroe").set_position(Vector2(111, 32 * (1 - (get_viewport().size.x/get_viewport().size.y - 1.76) * 1)))
	
	resolution_x = get_viewport().size.x
	camera_scale = Vector2(0.25 * 1024/resolution_x,0.25 * 1024/resolution_x) / 0.2
	set_zoom(camera_scale)
	
	get_viewport().connect("size_changed",self,"resize")
	
	if get_parent().get_parent().has_method("Fight_Scene") or (get_parent().get_parent().has_method("First_Scene") && !GLOBAL.first_cat_scene):
		_set_current(true)
	
	if get_parent().get_parent().has_method("Temple_lvl") && GLOBAL.first_starting_temple_lvl == false:
		_set_current(true)
		
	if get_parent().get_parent().has_method("Temple_lvl") && get_parent().get_parent().has_node("Ghost"):
		_set_current(false)

func _physics_process(delta):
	#if get_viewport().size.x/get_viewport().size.y > 1.76:
	#	get_parent().get_node("CanvasLayer").set_position(Vector2(-108, -15 * (1 + (get_viewport().size.x/get_viewport().size.y - 1.76) * 2)))
	#print(get_viewport().size)
	#print(get_parent().get_node("CanvasLayer").get_position())
	#print(get_viewport())
	#print(get_tree().get_root())
	pass
"""
	#get_viewport().connect("size_changed",self,"resize")
	#resolution_x = get_viewport().size.x
	#camera_scale = Vector2(0.25 * 1024/resolution_x,0.25 * 1024/resolution_x)
	#set_zoom(camera_scale)

	match get_viewport().size.x:
		float(2340):
			#set_zoom(Vector2(1 - 0.5 * get_viewport().size.x/1024,1 - 0.5 * get_viewport().size.x/1024))
			set_zoom(camera_scale)
		float(2560):
			set_zoom(camera_scale)
		float(3120):
			set_zoom(camera_scale)
		float(2400):
			set_zoom(camera_scale)
		float(3040):
			set_zoom(camera_scale)
		float(2280):
			set_zoom(camera_scale)
		float(2160):
			set_zoom(camera_scale)
		float(2960):
			set_zoom(camera_scale)
		float(2160):
			set_zoom(camera_scale)
		float(2880):
			set_zoom(camera_scale)
		float(1920):
			set_zoom(camera_scale)
		float(1280):
			set_zoom(camera_scale)
		float(1920):
			set_zoom(camera_scale)
		float(2480):
			set_zoom(camera_scale)
		float(2208):
			set_zoom(camera_scale)
		float(2428):
			set_zoom(camera_scale)
		float(2636):
			set_zoom(camera_scale)
			"""

func resize():
	if get_viewport().size.x/get_viewport().size.y > 1.76:
		get_parent().get_node("CanvasLayer").set_position(Vector2(-108, -15 * (1 + (get_viewport().size.x/get_viewport().size.y - 1.76) * 2)))
		get_parent().get_node("Jumping_Button").set_position(Vector2(89, -16 * (1 + (get_viewport().size.x/get_viewport().size.y - 1.76) * 2)))
		get_parent().get_node("Buttons_Of_Heroe").set_position(Vector2(111, 32 * (1 - (get_viewport().size.x/get_viewport().size.y - 1.76) * 1)))
	resolution_x = get_viewport().size.x
	camera_scale = Vector2(0.25 * 1024/resolution_x,0.25 * 1024/resolution_x) / 0.2
	set_zoom(camera_scale)
