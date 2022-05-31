extends Control



var max_hp: int = 100
onready var player = get_parent().get_parent().get_node("Player")
onready var tween = $Tween
onready var health_bar = get_node("TextureProgress")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_update_health_bar(100)

func _update_health_bar(new_value: int) -> void:
	var __ = tween.interpolate_property(
		health_bar,
		"value", 
		health_bar.value,
		new_value, 
		0.5,
		Tween.TRANS_QUINT,
		Tween.EASE_OUT
	)
	__ = tween.start()


func _on_Boss_hp_change(new_value) -> void:
	_update_health_bar(new_value)
