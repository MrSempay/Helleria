extends KinematicBody2D


var heroe = get_parent().get_node("Heroe")


func _physics_process(delta):
	if heroe.position.x > 0:
		$Sprite.flip_h = -1
		#(true)
	else:
		$Sprite.flip_h = 1
		#(false)
		
	

