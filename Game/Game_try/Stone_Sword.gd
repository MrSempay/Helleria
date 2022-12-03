extends Area2D


var damage = 10


onready var anim = $AnimationPlayer


func attack():
	anim.play("Animation_Sword")


func _on_Area2D_body_entered(body: Node):
	if body.has_method("handle_hit") && !body.has_method("start_jump"):
		body.handle_hit(damage)
