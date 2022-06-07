extends CanvasLayer


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$HBoxContainer/Label.text = str(GameManager.fruits)


func _process(delta: float) -> void:
	$HBoxContainer/Label.text = str(GameManager.fruits)
