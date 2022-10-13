extends CollisionShape2D


func _physics_process(delta):
	if GLOBAL.vector_of_moving < 0:
		position.x = -320
	else:
		position.x = 62.5
