extends Node2D

var mouse_in_area = false
var variation_energy
var scaleT = 1


func _physics_process(delta):

	if $AnimatedSprite.get_animation() == "torchOn":
		variation_energy = 2.8 * scaleT
		$Light2D.set_energy(variation_energy)


func _on_Area2D_body_entered(body):
	if get_parent().has_node("Heroe"):
		if body.has_method("start_jump_heroe") && get_parent().get_node("Heroe/Camera_Of_Heroe").is_current():
			$Entering.set_visible(true)
			
		

func _on_Area2D_body_exited(body):
	if get_parent().has_node("Heroe"):
		if body.has_method("start_jump_heroe") && get_parent().get_node("Heroe/Camera_Of_Heroe").is_current():
			$Entering.set_visible(false)

	
	
func _input(event):

	if event is InputEventScreenTouch and event.is_pressed() && mouse_in_area:
		match $AnimatedSprite.get_animation():
			"torchOn":
				$Timer_Without_Smoke.start()
				$AnimatedSprite.play("ofTorchSmoke")
				$Light2D.set_energy(1.25)
			"ofTorchSmoke":
				$AnimatedSprite.play("torchOn")
				$Light2D.set_energy(2.8)
			"ofTorchWithoutSmoke":
				$AnimatedSprite.play("torchOn")
				$Light2D.set_energy(2.8)


func _on_Area2D_mouse_entered():
	mouse_in_area = true


func _on_Area2D_mouse_exited():
	mouse_in_area = false


func _on_Timer_Random_Energy_Light_timeout():
	match self.name[0]:
		"L":
			scaleT = 1 + randf()/50
		"N":
			scaleT = 1 + randf()/30
		"Z":
			scaleT = 1


func _on_Timer_Without_Smoke_timeout():
	if $AnimatedSprite.get_animation() == "ofTorchSmoke":
		$AnimatedSprite.play("ofTorchWithoutSmoke")
