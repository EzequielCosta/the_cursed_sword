extends Node2D


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass


func _on_Boss_turn_night(night) -> void:
	if (night):
		$AnimationPlayer.play("turn_night")
		$AudioStreamPlayer2D.stop()
		$AudioBoss.play()
		$Boss/VisibilityEnabler2D.queue_free()
	#else:
		#$AnimationPlayer.play_backwards("turn_night")
