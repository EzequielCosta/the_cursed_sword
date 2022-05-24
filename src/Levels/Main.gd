extends Node2D


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$CanvasLayer/LifeLabel.text = str(GameManager.life_player)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass


func _physics_process(delta: float) -> void:
	$CanvasLayer/LifeLabel.text = "Life: " + str(GameManager.life_player)
