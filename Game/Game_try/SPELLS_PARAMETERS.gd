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


"""Stone sword"""


var manacost_stone_sword_Heroe = 10
var damage_stone_sword_Heroe = 10
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


"""Stone sword"""

var manacost_stone_sword_Belotur = 0
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
var speed_stone_Belotur = 250
var calldown_stone_Belotur = 0.5


#_________Adalard_________#


"""Sword"""

var manacost_sword_Adalard = 10
var damage_sword_Adalard = 10
var scale_animation_speed_swrod_Adalard = 1

"""Armor"""

var manacost_armor_Adalard = 10
var fraction_absorbed_damage_armor_Adalard = 0.7
var scale_animation_speed_armor_Adalard = 1
var duration_armor_Adalard = 10
var calldown_armor_Adalard = 25

"""Push"""

var manacost_push_Adalard = 10
var damage_push_Adalard = 10
var scale_animation_speed_push_Adalard = 1
var duration_preparation_push_Adalard = 2.5
var speed_persenage_push_Adalard = 3.5




