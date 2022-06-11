extends CanvasLayer

signal transitioned


func _ready() -> void:
	pass


func transition_in():
	$AnimationPlayer.play("transition_in")


func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	if anim_name == "transition_in":
		emit_signal("transitioned")
		$AnimationPlayer.play("transition_out")
		
	
