extends Area2D


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass


func _on_Map_body_entered(body: Node) -> void:
	if (body.name == "Player"):
		GameManager.level += 1;
		$Transition.transition_in()
		


func _on_Transition_transitioned() -> void:
	get_tree().change_scene("res://src/Levels/Level"+str(GameManager.level)+".tscn");
