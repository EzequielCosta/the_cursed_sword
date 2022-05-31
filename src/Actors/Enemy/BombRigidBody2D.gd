extends RigidBody2D


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass




func _on_BombOnArea_body_entered(body: Node) -> void:
	if body.name == "Player":
		$TimerBombExplode.start(2)
	


func _on_AnimatedSprite_animation_finished() -> void:
	if $AnimatedSprite.animation == "explode":
		queue_free()


func _on_TimerBombExplode_timeout() -> void:
	$AnimatedSprite.play("explode")
	$ExplodeCollision/ExplodeCollisionShape2D.disabled = false;


func _on_BombEnemy_body_entered(body: Node) -> void:
	pass


func _on_BombRigidBody2D_body_entered(body: Node) -> void:
	if body.name == "Player":
		body.take_attack()


func _on_StompCollison_area_entered(area: Area2D) -> void:
	if (area.name == 'SwordArea'):
		$AnimatedSprite.play("explode")
		$ExplodeCollision/ExplodeCollisionShape2D.disabled = true;


func _on_ExplodeCollision_body_entered(body: Node) -> void:
	
	if (body.name == 'Player'):
		body.take_attack();

