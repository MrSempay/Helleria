extends Node

var locations = {
	"Garsia_Boss_Fight_Scene": {
		
		
		#"characters_for_uploading": {"Gasria": false, "Belotur": true, "Jeison": true, "Adalard": true}
		"characters_for_uploading": {"Gasria": false}
	},
	
	"Scene_Fight_Jsn": {
		
		"characters_for_uploading": {"Jeison": false, "Her": false, "Sed": false},
		
		"Areas_For_Moving": {
			"Moving_Area_1": [["Her", "Sed"], [[Vector2(170,530)], [Vector2(170,530)]], [false, false], "Moving_Area_1", null, [4, 4]],
			"Moving_Area_2": [["Her", "Sed"], [[Vector2(670,400)], [Vector2(670,400)]], [false, false], "Moving_Area_2", null, [4, 4]]
		}
	
	},
	
	"1lvl_Batle_Scene": {
		
		"characters_for_uploading": {"Adalard": true},
	},
	
	"First_Scene": {
		"enemies_fight_scenes": {
			"Belotur": "Max_Level_Fight_Scene",
			"Adalard": "1lvl_Batle_Scene",
			"Jeison": "Scene_Fight_Jsn",
			"Gasria": "Garsia_Boss_Fight_Scene"
		}
	},
	
	"Max_Level_Fight_Scene": {
		"characters_for_uploading": {"Belotur": true}
	}
}
