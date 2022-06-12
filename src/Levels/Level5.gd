extends Node2D



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _on_Boss_turn_night(night) -> void:
	if (night):
		$AnimationPlayer.play("turn_night")
		$AudioStreamPlayer2D.stop()
		$AudioBoss.play()
		$Boss/VisibilityEnabler2D.queue_free()
	


func _on_Boss_die() -> void:
	$DialogLayer/DialogBox.visible = true
	$DialogLayer/DialogBox.start("dialog_end")


func _on_DialogBox_done_read(value) -> void:
	$Transition.transition_in()


func _on_Transition_transitioned() -> void:
	get_tree().change_scene("res://src/UI/Win.tscn")
