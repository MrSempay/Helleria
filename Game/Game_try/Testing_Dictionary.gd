extends Node2D

var file = File.new()
var mass = []
var vector = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in 10:
		vector = Vector2(i, i + 1)
		mass.append(vector)
		print(mass[i])
	file.open("user://save_game.dat", File.WRITE)
	file.store_string(mass)
	#file.close()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
