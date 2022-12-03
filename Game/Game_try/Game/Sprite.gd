extends Sprite


func _physics_process(delta):
	if GLOBAL.vector_of_moving < 0:
		position.x = -130
		self.flip_h = -1
	else:
		position.x = -35
