extends Control

signal transitioned


func _ready() -> void:
	transition_in()


func transition_in():
	$CanvasLayer/AnimationPlayer.play("transition_in")


func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	if anim_name == "transition_in":
		emit_signal("transitioned")
		$CanvasLayer/AnimationPlayer.play("transition_out")
		
	
