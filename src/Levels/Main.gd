extends Node2D


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	#$CanvasLayer/LifeLabel.text = str(GameManager.life_player)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass


func _physics_process(delta: float) -> void:
	pass
	#$CanvasLayer/LifeLabel.text = "Life: " + str(GameManager.life_player)


func _on_AudioStreamPlayer2D_finished() -> void:
	$AudioStreamPlayer2D.play();
