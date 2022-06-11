extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _on_ButtonBack_pressed() -> void:
	get_tree().change_scene("res://src/UI/MainMenu.tscn")
	#$Transition.transition_in()

func _on_Transition_transitioned() -> void:
	get_tree().change_scene("res://src/UI/MainMenu.tscn")
