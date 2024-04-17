extends Node

var locations = {
	"Garsia_Boss_Fight_Scene": {
		
		
		#"characters_for_uploading": {"Garsia": false, "Belotur": true, "Jeison": true, "Adalard": true}
		"characters_for_uploading": {"Garsia": false}
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
			"Garsia": "Garsia_Boss_Fight_Scene"
		},
		
		"characters_for_uploading": {"Garsia": true, "Jeison": true, "Belotur": true, "Adalard": true, "Aglea": true, "Akira": true}
		#"characters_for_uploading": {"Garsia": false}
	},
	
	"Max_Level_Fight_Scene": {
		"characters_for_uploading": {"Belotur": true}
	},
	
	"Temple_lvl": {
		"characters_for_uploading": {}
	}
}
