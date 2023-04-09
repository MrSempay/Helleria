extends Node


##########_ОПИСАНИЕ_##########

# manacost - потребляемая мана для спела.
# damage - урон спела/летящего снаряда от спела.
# scale_animation_speed - скорость анимации персонажа при касте спела относительно нор-
#                         мального значения (1). То есть 1.5 соответствует ускорению ка-
#                         та на 50%. Часть спелов не имеют КД, скорость их применения ог-
#                         раничивается лишь скоростью анимации (например мечи).
# speed - скорость летящего снаряда.
# calldown - перезарядка спела.
# stune_duration - длительность оглушения.
# amount - количество расходуемых зарядов спела/снарядов.

##########_КОНЕЦ_##########

 
#_________Belotur_________#


"""Stone sword"""

var manacost_stone_sword_Belotur = 0
var damage_stone_sword_Belotur = 10
var scale_animation_speed_swrod_Belotur = 1

"""Hedgehod"""

var manacost_hedgehod = 10
var damage_hedgehod = 10
var scale_animation_speed_hedgehod_Belotur = 1
var calldown_hedgehod = 7
var stun_duration_hedgehod = 2.5

"""Stone"""

var manacost_stone_Belotur = 10
var damage_stone_Belotur = 10
var scale_animation_speed_stone_Belotur = 1
var speed_stone_Belotur = 250
var calldown_stone_Belotur = 55


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
var calldown_column_Heroe = 16
var stun_duration_column_Heroe = 3

"""Bow"""

var manacost_bow_Heroe = 10
var damage_bow_Heroe = 10
var scale_animation_speed_bow_Heroe = 1
var speed_arrow_Heroe = 300
var amount_arrow_Heroe = 5
#var calldown_bow_Heroe // Нужно ли?
