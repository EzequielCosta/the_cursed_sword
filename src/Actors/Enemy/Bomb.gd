extends Area2D


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_BombOnArea_body_entered(body: Node) -> void:
	if body.name == "Player":
		print("entrou na bomba")
		$TimerBombExplode.start(1)
	


func _on_AnimatedSprite_animation_finished() -> void:
	if $AnimatedSprite.animation == "explode":
		queue_free()


func _on_TimerBombExplode_timeout() -> void:
	$AnimatedSprite.play("explode")
	$ExplodeCollisionShape2D.disabled = false;


func _on_BombEnemy_body_entered(body: Node) -> void:
	if body.name == "Player":
		print("Player atingido pela bomba")
		#body.queue_free();
