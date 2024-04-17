extends "res://Locations.gd"

var enemies_on_floor = {
	"Garsia": "Third",
	"Belotur": "Second",
	"Jeison": "Third",
	"Adalard": "First"
}


var heroe_on_floor = "First"

func Fight_Scene():
	pass

func _ready():
	if self.has_node("Areas_For_Floors"):
		for i in range($Areas_For_Floors.get_children().size()):
			##($Areas_For_Floors.get_children())
			$Areas_For_Floors.get_children()[i].connect("area_entered", self, "_on_Area_For_Floor_entered", [$Areas_For_Floors.get_children()[i]])
			

func _physics_process(delta):
	$Line2D2.set_points(get_node("Garsia").nav_path)

func _on_Area_For_Floor_entered(area, area_which_was_triggered):
	if area.get_name() == "Area_For_Stop_Machine":
		enemies_on_floor[area.get_parent().get_name()] = area_which_was_triggered.get_name().split("_")[1]
		#if area.get_parent().get_name() == "Adalard":
		#53н7 	#(enemies_on_floor["Adalard"])
	if area.get_name() == "Heroe_Area":
		heroe_on_floor = area_which_was_triggered.get_name().split("_")[1]
		
func _on_NoSpeed_Area2_body_entered(body):
		if body.has_method("enemy"):
			#("TRUE")
			if body.get_node("RayCastHorizontal_For_Heroe").get_collider():
				if !body.get_node("RayCastHorizontal_For_Heroe").get_collider().has_method("Heroe"):
					body.speed = 0
					body.stop_machine = true
			body.speed = 0
			body.stop_machine = true


func _on_Speed_Area_body_entered(body):
	if body.has_method("enemy"):
		body.speed = 2.5
		body.stop_machine = false



		
func _on_timer_for_timer_start_moving_timeout(area, timer):
	area.get_parent().speed = 2.5
	area.get_parent().stop_machine = false
	timer.queue_free()



