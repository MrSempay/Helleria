extends Node


##########_ОПИСАНИЕ_##########

# manacost - потребляемая мана для спела.
# damage - урон спела/летящего снаряда от спела.
# scale_animation_speed - скорость анимации персонажа при касте спела относительно нор-
#                         мального значения (1). То есть 1.5 соответствует ускорению ка-
#                         та на 50%. Часть спелов не имеют КД, скорость их применения ог-
#                         раничивается лишь скоростью анимации (например мечи).
# speed - скорость летящего снаряда.
# speed_persenage = скорость персонажа при активации спела.
# calldown - перезарядка спела (секунды).
# stune_duration - длительность оглушения (секунды).
# amount - количество расходуемых зарядов спела/снарядов.
# fraction_absorbed_damage - доля поглощаемого урона при активации спела. 1 = 100% поглощения.
# duration_preparation - длительность подготовки спела (секунды).


##########_КОНЕЦ_##########


#_________Heroe_________#


var HP_Heroe = 350
var mana_Heroe = 250

"""Stone sword"""


var manacost_stone_sword_Heroe = 10
var damage_stone_sword_Heroe = 100
var scale_animation_speed_swrod_Heroe = 1
#var calldown_sword_Heroe // Нужно ли?

"""Column"""

var manacost_column_Heroe = 10
var damage_column_Heroe = 10
var scale_animation_speed_column_Heroe = 1
var calldown_column_Heroe = 6
var stun_duration_column_Heroe = 3

"""Bow"""

var manacost_bow_Heroe = 10
var damage_bow_Heroe = 10
var scale_animation_speed_bow_Heroe = 1
var speed_arrow_Heroe = 300
var amount_arrow_Heroe = 5
#var calldown_bow_Heroe // Нужно ли?
 

#_________Belotur_________#


var HP_Belotur = 300
var mana_Belotur = 250

"""Stone sword"""

var manacost_stone_sword_Belotur = 10
var damage_stone_sword_Belotur = 10
var scale_animation_speed_swrod_Belotur = 2
#var calldown_stone_sword_Belotur // Нужно ли?

"""Hedgehod"""

var manacost_hedgehod = 10
var damage_hedgehod = 10
var scale_animation_speed_hedgehod_Belotur = 1
var calldown_hedgehod = 7
var stun_duration_hedgehod = 2.5

"""Stone"""

var manacost_stone_Belotur = 1
var damage_stone_Belotur = 10
var scale_animation_speed_stone_Belotur = 1
var speed_stone_Belotur = 300
var calldown_stone_Belotur = 2




#_________Sed_________#


"""chaining"""

var manacost_chaining_Sed = 30
var calldown_chaining_Sed = 5
var chaining_stun_duration_Sed = 0
var chaining_slowdown_duration_Sed = 0
var chaining_slowdown_Sed = 0.5

"""shield_punch"""

var manacost_shield_punch_Sed = 20
var calldown_shield_punch_Sed = 5
var damage_shield_punch_Sed = 25

"""idle_shield"""

var fraction_absorbed_damage_armor_Sed = 1


#_________Her_________#


"""spear_jump"""

var manacost_spear_jump_Her = 30
var calldown_spear_jump_Her = 8

"""spear_punch"""

var manacost_spear_punch_Her = 20
var calldown_spear_punch_Her = 2
var damage_spear_punch_Her = 25

"""spear_squall"""

var manacost_spear_squall_Her = 20
var calldown_spear_squall_Her = 5
var damage_spear_squall_Her = 25

#_________Adalard_________#


var HP_Adalard = 2750
var mana_Adalard = 1500

"""Sword"""

var manacost_sword_Adalard = 0
var damage_sword_Adalard = 15
var scale_animation_speed_sword_Adalard = 1

"""Armor"""

var armor_manacost = 50
var fraction_absorbed_damage_armor_Adalard = 0.15
var scale_animation_speed_armor_Adalard = 1
var duration_armor = 5
var calldown_armor_Adalard = 12

"""Push"""

var manacost_push_Adalard = 10
var damage_push_Adalard = 10
var scale_animation_speed_push_Adalard = 1
var speed_persenage_push_Adalard = 2.5
var calldown_push_Adalard = 8
var stun_duration_push_Adalard = 1

var characters = {
	
	"Adalard": {
		"health": 2750,
		"mana": 1500,
		
		"handle_attack": {
			"handle_attack_damage": 15, 
			"handle_attack_calldown": 0,
			"handle_attack_manacost": 1,
		},
		"armor": {
			"armor_fraction_absorbed_damage": 0.15,
			"armor_manacost": 50,
			"armor_duration": 5,
			"armor_calldown": 12

		},
		"push": {
			"push_stun": 1, 
			"push_manacost": 50,
			"push_damage": 25,
			"push_calldown": 8,
			"push_speed": 2.5
		}
	},
	
	"Sed": {
		"health": 150,
		"mana": 150
	},
	
	"Her": {
		"health": 120,
		"mana": 150,
		"speed": 2,
		
		"handle_attack": {
			"handle_attack_damage": 15,  #Spear 
			"handle_attack_calldown": 0.5,
			"handle_attack_manacost": 1,
			"handle_attack_thrust": 10
		},
		"squall_attack": {
			"squall_attack_damage": 5,  #Spear 
			"squall_attack_calldown": 7,
			"squall_attack_manacost": 10,
			"squall_attack_stun": 0.2,
			"squall_attack_amount_attacks": 5,
			"squall_attack_thrust": 2
		},
		"jumping_to_point": {
			"jumping_to_point_calldown": 10,
			"jumping_to_point_manacost": 10
		}
	},
	
	"Jeison": {
		"health": 150,
		"mana": 250,
		"speed": 2,
		
		"damage_block_chain": {
			"damage_block_chain_fraction_absorbed_damage": 0.5, 
			"damage_block_chain_duration": 10,
			"damage_block_chain_calldown": 5,
			"damage_block_chain_consumption_health_in_second": 10
		},
		"cure_chain": {
			"cure_chain_regeneration_in_second": 5.0, 
			"cure_chain_duration": 10,
			"cure_chain_calldown": 5,
			"cure_chain_consumption_mana_in_second": 15
		},
		"damage_increase_chain": {
			"damage_increase_chain_increase": 1, 
			"damage_increase_chain_duration": 10,
			"damage_increase_chain_calldown": 5,
			"damage_increase_chain_consumption_health_in_second": 15
		}
	},
	
	"Gasria": {
		"health": 450,
		"mana": 22250,
		"speed": 2,
		
		"stone_wall": {
			"stone_wall_calldown": 0,
			"stone_wall_manacost": 15,
			"stone_wall_calldown_snare": 18
		},
		
		"destruction_wave": {
			"destruction_wave_damage": 13,
			"destruction_wave_manacost":50,
			"destruction_wave_calldown": 0,
			"destruction_wave_speed": 150,
			"destruction_wave_amount_bounces": 5
		},
		
		"fier_ball": {
			"fier_ball_damage": 50,
			"fier_ball_manacost": 20,
			"fier_ball_animation_speed_scale_creating_projectile": 0.75,
			"fier_ball_animation_speed_scale_flying_projectile": 3,
			"fier_ball_calldown": 0,
			"fier_ball_speed": 250
		},
		
		"invisibility": {
			"invisibility_consumption_mana_in_second": 5.0,
			"invisibility_duration": 0,
			"invisibility_calldown": 5
		},
		
		"call_of_the_dead": {

			"call_of_the_dead_consumption_mana_in_second": 15,
			"call_of_the_dead_calldown": 0,
			"call_of_the_dead_duration": 0 # if spell has to be endless 


		},
		
		"teleport": {
			"teleport_manacost": 5.0,
			"teleport_calldown": 0
		}
	},
	
	"Akira": {
		"health": 2750,
		"mana": 1500,
		"speed": 2
	},
	
	"Aglea": {
		"health": 2750,
		"mana": 1500,
		"speed": 2
	},
	
	"Belotur": {
		"health": 150,
		"mana": 1500,
		"speed": 2
	},
	
	"Heroe": {
		"health": 459,
		"mana": 1500,
		"speed": 2
	}
}


	
	
	
	
	

