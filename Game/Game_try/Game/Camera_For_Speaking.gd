extends Camera2D

var resolution_x
var camera_scale
# Declare member variables here. Examples:
# var a = 2
# var b = "text"



# Called when the node enters the scene tree for the first time.
func _ready():

	resolution_x = get_viewport().size.x
	camera_scale = Vector2(0.25 * 1024/resolution_x,0.25 * 1024/resolution_x) / 0.8
	set_zoom(camera_scale)
	
	get_viewport().connect("size_changed",self,"resize")
	if get_parent().has_method("First_Scene") && GLOBAL.first_cat_scene:
		_set_current(true)


func resize():
	resolution_x = get_viewport().size.x
	camera_scale = Vector2(0.25 * 1024/resolution_x,0.25 * 1024/resolution_x) / 0.7
	set_zoom(camera_scale)

