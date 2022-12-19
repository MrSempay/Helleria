extends Area2D

export (int) var damage := 10


onready var anim = $AnimationPlayer
onready var heroe = get_parent()
onready var heroe_mana = get_parent().get_node("Mana_Heroe")
onready var button = get_node("../../Button_First")
onready var count_of_arrow = get_node("../Sprite/Button_First/Arrow_Amount")
onready var enemy_weapon = get_node("../../Enemy_Main/Weapon_Enemy")
onready var button_first = get_node("../Sprite/Button_First")
onready var button_second = get_node("../Sprite/Button_Second")
onready var button_third = get_node("../Sprite/Button_Third")
onready var timer_of_sheld = $Timer_Of_Sheld
onready var timer_of_stone = get_node("Timer_Of_Sheld/Timer_Of_Stone")
onready var timer_of_hedgehod = get_node("Timer_Of_Sheld/Timer_Of_Hedgehod")
onready var shape = $CollisionShape2D


var count_hit_in_area = 0
var count_hit_in_sheld = 0
#var arrow = preload("res://Game/Arrow.tscn")
#var stone = preload("res://Game/Stone.tscn")
#var hedgehod = preload("res://Game/Hedgehod.tscn")
#var stone_sword = preload("res://Game/Stone_Sword.tscn")
var count_of_attacku = 0
var arrow_amount = 7
var beat_in_sheld = false
var first_spawn = true
#var stone_sword_1 = stone_sword.instance()
#var hedgehod_1 = hedgehod.instance()


func _ready():
	var position_of_weapon = Vector2(510, 425)
	self.set_position(position_of_weapon)

func _physics_process(delta):
	match GLOBAL.spell_of_button:
		"sheld":
			if GLOBAL.counter_of_third_button%2 != 0:
				shape.set_disabled(false)
				damage = 0
			elif enemy_weapon.count_of_attack > GLOBAL.count_of_containment || GLOBAL.counter_of_third_button%2 == 0:
				shape.set_disabled(true)
				
				
		"bow":
			shape.set_disabled(true)
			if GLOBAL.counter_of_bow > 0 && arrow_amount > 0:
				var arrow_1 = arrow.instance()
				arrow_1.position = $Position2D.global_position
				get_parent().get_parent().add_child(arrow_1)
				GLOBAL.counter_of_bow -= 1
				arrow_amount -= 1
				count_of_arrow.set_text(str(arrow_amount))
		"stone":
			var stone_1 = stone.instance()
			if GLOBAL.counter_of_stone > 0 && heroe_mana.value >= stone_1.manacost:
				heroe.mana_using(stone_1.manacost)
				stone_1.position = $Position2D.global_position
				get_parent().get_parent().add_child(stone_1)
				GLOBAL.counter_of_stone -= 1
				timer_of_stone.start()
				button_second.set_disabled(true)
			elif GLOBAL.counter_of_stone > 0 && heroe_mana.value < stone_1.manacost && GLOBAL.counter_of_second_button > 0:
				print("You haven't mana for this spell, need ", (stone_1.manacost - heroe_mana.value), " more mana!")
				GLOBAL.counter_of_stone -= 1
		"hedgehod":
			var hedgehod_1 = hedgehod.instance()
			if GLOBAL.counter_of_hedgehod > 0 && heroe_mana.value >= hedgehod_1.manacost:
				get_parent().get_parent().add_child(hedgehod_1)
				hedgehod_1.position = $Hedgehod.global_position
				heroe.mana_using(hedgehod_1.manacost)
				GLOBAL.counter_of_hedgehod -= 1
				timer_of_hedgehod.start()
				button_third.set_disabled(true)
			elif GLOBAL.counter_of_hedgehod > 0 && heroe_mana.value < hedgehod_1.manacost:
				print("You haven't mana for this spell, need ", (hedgehod_1.manacost - heroe_mana.value), " more mana!")
				GLOBAL.counter_of_hedgehod -= 1
				print(false)
		"stone_sword":
			if GLOBAL.counter_of_first_button == 1 && first_spawn:
				first_spawn = false
				stone_sword_1.position = $Sword_Position.position
				get_parent().add_child(stone_sword_1)
				stone_sword_1.attack()
			if GLOBAL.counter_of_first_button == 2 && !first_spawn:
				stone_sword_1.attack()
				GLOBAL.counter_of_first_button -= 1
				
			

func attack():
	anim.play("Attack_Animation")
	

func _on_Weapon_body_entered(body: Node) -> void:
	#print(true)
	if body.has_method("handle_hit") && !body.has_method("start_jump"):
		body.handle_hit(damage)
	#if body.has_method("attacl"):
		#print(shape.is_disabled())
	match GLOBAL.spell_of_button:
		"sheld":
			pass

func _on_Weapon_area_entered(area: Area2D):
	match GLOBAL.spell_of_button:
		"sheld":
			beat_in_sheld = true
			count_hit_in_sheld += 1
			if area.has_method("attack") && count_hit_in_sheld < GLOBAL.count_of_containment && GLOBAL.counter_of_third_button%2 != 0:
				shape.set_disabled(false)
				#get_parent().defense = 0
				if beat_in_sheld && heroe.beat_in_heroe:
					beat_in_sheld = false
					heroe.beat_in_heroe = false
					area.damage = 0
				if !beat_in_sheld && heroe.beat_in_heroe:
					area.damage = area.damage_save
			elif (area.has_method("attack") && count_hit_in_sheld > GLOBAL.count_of_containment) || GLOBAL.counter_of_third_button%2 == 0: 
				#get_parent().defense = 1
				area.damage = area.damage_save
				shape.set_disabled(true)
			if count_hit_in_sheld > GLOBAL.count_of_containment && !button_third.is_disabled():
				visible = not visible
				timer_of_sheld.start()
				button_third.set_disabled(true)
				shape.set_disabled(true)
				
				
	


func _on_Timer_Of_Sheld_timeout():
	GLOBAL.counter_of_third_button += 1
	shape.set_disabled(true)
	button_third.set_disabled(false)
	count_hit_in_sheld = 0




func _on_Timer_Of_Stone_timeout():
	button_second.set_disabled(false)


func _on_Timer_Of_Hedgehod_timeout():
	button_third.set_disabled(false)
