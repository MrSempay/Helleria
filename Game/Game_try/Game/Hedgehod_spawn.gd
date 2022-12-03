extends Position2D


func _physics_process(delta):
	if GLOBAL.vector_of_moving < 0:
		position.x = -939
	else:
		position.x = 639
