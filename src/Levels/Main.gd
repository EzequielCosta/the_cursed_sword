extends Node2D


func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	pass
	#$CanvasLayer/LifeLabel.text = "Life: " + str(GameManager.life_player)


func _on_AudioStreamPlayer2D_finished() -> void:
	$AudioStreamPlayer2D.play();
