extends StaticBody2D


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
export var impulse_player:float = 1000.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass


func _on_Spike_body_entered(body: Node) -> void:
	if body.name == "Player":
		body.take_attack()
		body.impulse_jump(impulse_player)
