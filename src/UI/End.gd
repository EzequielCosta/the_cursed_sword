extends Control


func _ready() -> void:
	$DialogLayer/DialogBox.start();



func _on_DialogBox_done_read(value) -> void:
	if (value):
		get_tree().change_scene("res://src/UI/MainMenu.tscn")
