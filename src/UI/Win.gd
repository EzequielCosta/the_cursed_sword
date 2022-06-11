extends Control


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass


func _on_ButtonRestart_pressed() -> void:
	$TransitionRestart.transition_in()


func _on_ButtonExit_pressed() -> void:
	$TransitionExit.transition_in()


func _on_Transition_transitioned() -> void:
	get_tree().change_scene("res://src/UI/MainMenu.tscn")


func _on_TransitionExit_transitioned() -> void:
	get_tree().quit()
