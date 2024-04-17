extends Node2D

var file = File.new()
var file_1 = File.new()
var mass = []
var vector = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	file.open("res://navigation.txt", File.WRITE)
	file_1.open("res://navigation.dat", File.WRITE)
	for i in 10:
		vector = Vector2(i, i + 1)
		mass.append(vector)
		##(mass[i])
		file.store_line(str(mass[i]))
		file_1.store_var((mass))
	file.close()
	file_1.close()
	file.open("res://navigation.txt", File.READ)
	##(file.get_line().find("1"))
	##(file.get_line().rstrip(")").lstrip("(").rstrip(","))
	var tet = file.get_line().split(",",true,1)
	var tet_1 = (tet[0].split("(",false,1))
	var tet_2 = (tet[1].split(")",true,1))
	#(float(tet_1[0]))
	#(float(tet_2[0]))

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
