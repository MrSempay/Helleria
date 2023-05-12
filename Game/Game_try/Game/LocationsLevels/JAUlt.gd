extends StaticBody2D

onready var heroe = get_parent().get_parent().get_node("Heroe")
onready var heroe_exsisting = get_parent().get_parent().has_node("Heroe")



func _physics_process(delta):
	if heroe_exsisting:
		if heroe.global_position.y > self.global_position.y:
			$CollisionShape2D.set_disabled(true)
		else:
			$CollisionShape2D.set_disabled(false)
