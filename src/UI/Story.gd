extends Node2D

var endStory:bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Player.run(2)

func _on_Player_stop_run(stop) -> void:
	if stop:
		$Timer.start(1)
		yield($Timer,"timeout")
		$DialogLayer/DialogBox.visible = true
		$DialogLayer/DialogBox.start()


func _on_DialogBox_done_read(value) -> void:
	
	if not(value):
		return
		
	if endStory:
		get_tree().change_scene("res://src/Levels/Main.tscn")
		return
		
	$Player.set_physics_process(true)
		


func _on_Area2D_body_entered(body: Node) -> void:
	if (body.name == "Player"):
		$Player.set_physics_process(false)
		$Player/AnimatedSprite.play("idle")
		$Sword/AnimationPlayer.play("get_sword")
		yield($Sword/AnimationPlayer,"animation_finished")
		endStory = true
		$DialogLayer/DialogBox.dialogPath = "res://src/Dialogs/dialog-start-enemy.json"
		$DialogLayer/DialogBox.visible = true
		$DialogLayer/DialogBox.start()
