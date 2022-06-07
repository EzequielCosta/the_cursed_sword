extends CanvasLayer


const MIN_HEALTH: int = 24
var max_hp: int = 4
onready var player = get_parent().get_parent().get_node("Player")
onready var tween = $TextureProgress/Tween
onready var health_bar = get_node("TextureProgress")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var health = int( 100 - MIN_HEALTH) * float(GameManager.life_player / max_hp) + MIN_HEALTH
	_update_health_bar(health)

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

func _physics_process(delta: float) -> void:
	if (GameManager.fruits == 5):
		GameManager.life_player += 0.5
		GameManager.fruits = 0
		var new_health = int( 100 - MIN_HEALTH) * float(GameManager.life_player / max_hp) + MIN_HEALTH
		_update_health_bar(new_health)


func _on_Player_hp_change(new_value) -> void:
	var new_health = int( 100 - MIN_HEALTH) * float(new_value / max_hp) + MIN_HEALTH
	_update_health_bar(new_health)
