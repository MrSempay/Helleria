extends AnimatedSprite


var mouse_in_area



func _ready():
	play("idle")




func _on_Area2D_body_entered(body):
	if get_parent().has_node("Heroe"):
		if body.has_method("start_jump_heroe") && get_parent().get_node("Heroe/Camera_Of_Heroe").is_current():
			$Entering.set_visible(true)
			if get_animation() != "door":
				play("idle_heroe")
		

func _on_Area2D_body_exited(body):
	if get_parent().has_node("Heroe"):
		if body.has_method("start_jump_heroe") && get_parent().get_node("Heroe/Camera_Of_Heroe").is_current():
			$Entering.set_visible(false)
			if get_animation() != "door":
				play("idle")
	
	
func _input(event):

	if event is InputEventScreenTouch and event.is_pressed() && mouse_in_area:
		play("door")



func _on_Door_animation_finished():
	if get_animation() == "door":
		play("idle")
		if get_parent().has_method("Temple_lvl"):
			GLOBAL.scene("First_Scene")
			get_parent().queue_free()
			
		if get_parent().has_method("First_Scene") && !GLOBAL.first_cat_scene:
			GLOBAL.scene("Temple_lvl")
			get_parent().queue_free()


func _on_Area2D_mouse_entered():
	mouse_in_area = true


func _on_Area2D_mouse_exited():
	mouse_in_area = false


