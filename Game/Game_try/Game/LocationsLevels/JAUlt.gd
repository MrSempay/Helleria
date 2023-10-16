extends StaticBody2D

onready var heroe = null
onready var heroe_exsisting = get_parent().get_parent().has_node("Heroe")



func _physics_process(delta):
	if get_parent().get_parent().get_name() != "Garsia_Boss_Fight_Scene":
		if get_parent().get_parent().has_node("Heroe") && heroe == null:
			heroe = get_parent().get_parent().get_node("Heroe")
		#if heroe != null && is_instance_valid(heroe):
		#	if heroe.global_position.y > self.global_position.y:
		#		$CollisionShape2D.set_disabled(true)
		#	else:
		#		$CollisionShape2D.set_disabled(false)
