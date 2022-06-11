extends CanvasLayer

func _ready() -> void:
	
	change_level()


func change_level():
	$HBoxContainer/LevelIcon.texture = load(prepare_path_icon_level())

func prepare_path_icon_level():
	if GameManager.level < 10:
		return "res://assets/Menu/Levels/0"+str(GameManager.level)+".png"
		
	return "res://assets/Menu/Levels/"+str(GameManager.level)+".png"	
