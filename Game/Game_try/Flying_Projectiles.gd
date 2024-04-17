extends Area2D


onready var heroe = get_node("../Heroe")
onready var collision_of_stone = get_node("CollisionShape2D")
var name_spell
var selfish
var vector = Vector2.ZERO

func _ready():
	#$Sprite.get_sprite_frames().add_animation("ibo")
	#$Sprite.get_sprite_frames().add_frame("ibo", load("res://Anims/Aglea/Ядро изменений/Руки копьё/anim333.png"))
	var dir_spell = Directory.new()
	if dir_spell.open("res://Anims/Flying_projectiles/" + name_spell + "/") == OK:
		dir_spell.list_dir_begin(true)
		var folder_name_of_animation = dir_spell.get_next()
		while folder_name_of_animation != "":
			var dir_animation_of_spell = Directory.new()
			if dir_animation_of_spell.open("res://Anims/Flying_projectiles/" + name_spell + "/" + folder_name_of_animation + "/") == OK:
				dir_animation_of_spell.list_dir_begin(true)
				var animation_frame = dir_animation_of_spell.get_next()
				##(folder_name_of_animation)
				while animation_frame != "":
					if not animation_frame.ends_with(".import"):
						$Sprite.get_sprite_frames().add_frame(folder_name_of_animation, load("res://Anims/Flying_projectiles/" + name_spell + "/" + folder_name_of_animation + "/" + animation_frame))
					animation_frame = dir_animation_of_spell.get_next()
			folder_name_of_animation = dir_spell.get_next()
	#else:
		#("An error occurred when trying to access the path.")
	$Sprite.play("creating_projectile")

	if get_node("../" + selfish + "/RayCastFlyingProjectile").get_collider():
		vector = get_node("../Heroe").global_position - self.global_position + Vector2(0,7)
	var sprite_of_owner_projectile = get_parent().get_node(selfish + "/Sprite")
	$Sprite.flip_h =  sprite_of_owner_projectile.is_flipped_h()
	sprite_of_owner_projectile.get_sprite_frames().set_animation_speed("A_" + name_spell, sprite_of_owner_projectile.get_sprite_frames().get_frame_count("A_" + name_spell) * 5/$Sprite.get_sprite_frames().get_animation_speed("creating_projectile"))
	sprite_of_owner_projectile.set_speed_scale(SPELLS_PARAMETERS.characters[selfish][name_spell][name_spell + "_animation_speed_scale_creating_projectile"])
	$Sprite.set_speed_scale(SPELLS_PARAMETERS.characters[selfish][name_spell][name_spell + "_animation_speed_scale_creating_projectile"])



func _physics_process(delta):
	if $Sprite.get_frame() == 7:
		_on_Sprite_animation_finished()
	##($Sprite.get_frame())
	##($Sprite.get_sprite_frames().get_frame_count("creating_projectile"))
	##($Sprite.get_sprite_frames().get_frame_count("creating_projectile"))
	#for i in range($Sprite.get_sprite_frames().get_frame_count("creating_projectile")):
	#	#($Sprite.get_sprite_frames().get_frame("creating_projectile", i))
	if $Sprite.get_animation() == "flying_projectile":
		translate(SPELLS_PARAMETERS.characters[selfish][name_spell][name_spell + "_speed"] * delta * vector.normalized())


func _on_VisibilityNotifier2D_screen_exited():
	if get_parent().has_node("Heroe"):
		if heroe.is_on_floor():
			queue_free()
		

func _on_Sprite_animation_finished():
	if $Sprite.get_animation() == "creating_projectile":
		collision_of_stone.set_disabled(false)
		$Sprite.play("flying_projectile")
		$Sprite.set_speed_scale(SPELLS_PARAMETERS.characters[selfish][name_spell][name_spell + "_animation_speed_scale_flying_projectile"])


func _on_Flying_Projectile_body_entered(body):
	if body.has_method("handle_hit") && body.has_method("start_jump_heroe"):
		body.handle_hit(SPELLS_PARAMETERS.characters[selfish][name_spell][name_spell + "_damage"], get_parent().get_node(selfish))
		queue_free()
	if !body.has_method("handle_hit"):
		queue_free()
