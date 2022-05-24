extends KinematicBody2D

var speed: = Vector2(30.0, 0)
var _velocity = Vector2.ZERO
const FLOOR_NORMAL: = Vector2.UP
var gravity = 2000

func _ready() -> void:
	set_physics_process(false)
	_velocity.x = -speed.x
	
func _physics_process(delta: float) -> void:
	_velocity.y += gravity * delta
	_velocity.x *= -1 if is_on_wall() else 1	
	$AnimatedSprite.flip_h = _velocity.x < 0
	_velocity.y = move_and_slide(_velocity, FLOOR_NORMAL).y
	"""
	if ($DetectorPlayer.collide_with_bodies):
		print($DetectorPlayer.get_collider())
		print($DetectorPlayer.collide_with_bodies)
		$AnimatedSprite.play("attack")
		$SwordArea2D/SwordCollisionShape2D.modulate = "#fff"
		$SwordArea2D/SwordCollisionShape2D.disabled = false
		_velocity.x = 0
		#set_physics_process(false);
	"""

func _on_PlayerNearArea2D_body_entered(body: Node) -> void:
	pass
	"""
	print(body.name)
	if (body.name == "Player"):
		$AnimatedSprite.play("attack")
		#$SwordArea2D/SwordCollisionShape2D.modulate = "#fff"
		$SwordArea2D/SwordCollisionShape2D.disabled = false
		#if ($DetectorPlayer.is_colliding()):
			#print("Colide com areas " + $DetectorPlayer.collide_with_areas);
		set_physics_process(false);
	"""
		
		

func _on_SwordArea2D_body_entered(body: Node) -> void:
	GameManager.life_player -= 1
	if not(GameManager.life_player):
		body.queue_free()
	body.get_node('AnimatedSprite').modulate = "#db2c2c"
	

func _on_AnimatedSprite_animation_finished() -> void:
	if $AnimatedSprite.animation == "death":
		queue_free()
	elif $AnimatedSprite.animation == "attack":
		$SwordArea2D/SwordCollisionShape2D.disabled = true



func _on_AttackPlayerArea2D_area_entered(area: Area2D) -> void:
	if (area.name == "SwordArea"):
		$AnimatedSprite.play("death")


func _on_SwordArea2D_area_entered(area: Area2D) -> void:
	pass


func _on_PlayerNearArea2D_area_entered(area: Area2D) -> void:
	if area.name == 'CollisionEnemy':
		$AnimatedSprite.play("attack")
		#$SwordArea2D/SwordCollisionShape2D.disabled = false
		set_physics_process(false);


func _on_AnimatedSprite_frame_changed() -> void:
	if $AnimatedSprite.animation == "attack"  and $AnimatedSprite.frame == 6:
		 $SwordArea2D/SwordCollisionShape2D.disabled = false
