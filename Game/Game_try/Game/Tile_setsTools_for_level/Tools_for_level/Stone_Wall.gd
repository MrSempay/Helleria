extends StaticBody2D

var first = true

func _ready():
	if get_parent().get_name() == "PositionsWalls":
		$AnimatedSprite.flip_h = get_parent().global_position.x > self.global_position.x

func stone_wall_self():
	pass

func _physics_process(delta):
	if first:
		if $AnimatedSprite.is_flipped_h():
			$CollisionShape2D.set_position($CollisionShape2D.get_position() + Vector2(16,0))
			first = false

func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.get_animation() == "wall_destruction":
		self.queue_free()
