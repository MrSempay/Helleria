extends CollisionShape2D


func _physics_process(delta):
	if GLOBAL.vector_of_moving < 0:
		position.x = -160
	else:
		position.x = 0
