extends Node2D

var endStory:bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$PlayerStory.run(2)


func _on_DialogBox_done_read(value) -> void:
	
	if not(value):
		return
		
	if endStory:
		$Transition.transition_in()
		return
		
	$PlayerStory.set_physics_process(true)
		


func _on_Area2D_body_entered(body: Node) -> void:
	if (body.name == "PlayerStory"):
		$PlayerStory.set_physics_process(false)
		$PlayerStory/AnimatedSprite.play("idle")
		$Sword/AnimationPlayer.play("get_sword")
		yield($Sword/AnimationPlayer,"animation_finished")
		endStory = true
		#$DialogLayer/DialogBox.dialogPath = "res://src/Dialogs/dialog-start-enemy.json"
		$DialogLayer/DialogBox.visible = true
		$DialogLayer/DialogBox.start("dialog_start_enemy")


func _on_Transition_transitioned() -> void:
	get_tree().change_scene("res://src/Levels/Level1.tscn")


func _on_PlayerStory_stop_run(stop) -> void:
	if stop:
		$Timer.start(1)
		yield($Timer,"timeout")
		$DialogLayer/DialogBox.visible = true
		$DialogLayer/DialogBox.start("dialog_start")
