#extends StaticBody2D
extends "res://ItemGettable.gd"


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass


func _on_AreaPlayer_body_entered(body: Node) -> void:
	if (body.name == "Player"):
		GameManager.fruits += 1
		$AnimationPlayer.play("get")
		#emit_signal("get_item")
		
func _add_life() -> void:
	if GameManager.fruits == 5 and GameManager.life_player != 4:
		GameManager.life_player += 0.5
		GameManager.fruits = 0
		
