extends Control

func _ready() -> void:
	pass # Replace with function body.

func _on_Button_pressed() -> void:
	get_tree().change_scene("res://src/UI/Story.tscn")
