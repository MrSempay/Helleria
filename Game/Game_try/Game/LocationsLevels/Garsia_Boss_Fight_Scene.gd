#extends "res://Locations.gd"

var enemies_on_floor = {
	"Gasria": "Third",
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
			#print($Areas_For_Floors.get_children())
			$Areas_For_Floors.get_children()[i].connect("area_entered", self, "_on_Area_For_Floor_entered", [$Areas_For_Floors.get_children()[i]])
			

func _on_Area_For_Floor_entered(area, area_which_was_triggered):
	if area.get_name() == "Area_For_Stop_Machine":
		enemies_on_floor[area.get_parent().get_name()] = area_which_was_triggered.get_name().split("_")[1]
		#if area.get_parent().get_name() == "Adalard":
		#53н7 	print(enemies_on_floor["Adalard"])
	if area.get_name() == "Heroe_Area":
		heroe_on_floor = area_which_was_triggered.get_name().split("_")[1]
