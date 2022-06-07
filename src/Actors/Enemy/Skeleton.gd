extends KinematicBody2D

var speed: = Vector2(40.0, 0)
var _velocity = Vector2.ZERO
const FLOOR_NORMAL: = Vector2.UP
var gravity = 2000
onready var player : Node2D
var die = false

func _ready() -> void:
	set_physics_process(false)
	_velocity.x = -speed.x
	player = get_parent().get_node("Player")
	
	
func _physics_process(delta: float) -> void:
	_velocity.y += gravity * delta
	player =  get_parent().get_node("Player")
	#_setDirection()
	_direction_move()
	$AnimatedSprite.flip_h = _velocity.x < 0
	_velocity.y = move_and_slide(_velocity, FLOOR_NORMAL).y
	

func _on_PlayerNearArea2D_body_entered(body: Node) -> void:
	pass
		

func _on_SwordArea2D_body_entered(body: Node) -> void:
	if (body.name == "Player" and not(body.get_die())):
		body.take_attack()
	

func _on_AnimatedSprite_animation_finished() -> void:
	if $AnimatedSprite.animation == "death":
		queue_free()
	elif $AnimatedSprite.animation == "attack":
		$SwordArea2D/SwordCollisionShape2D.disabled = true



func _on_AttackPlayerArea2D_area_entered(area: Area2D) -> void:
	if (area.name == "SwordArea"):
		die()
		


func _on_SwordArea2D_area_entered(area: Area2D) -> void:
	pass


func _on_PlayerNearArea2D_area_entered(area: Area2D) -> void:
	if area.name == 'CollisionEnemy' and not(die):
		$AnimatedSprite.play("attack")
		#$SwordArea2D/SwordCollisionShape2D.disabled = false
		set_physics_process(false);


func _on_AnimatedSprite_frame_changed() -> void:
	if $AnimatedSprite.animation == "attack"  and $AnimatedSprite.frame >= 6:
		 $SwordArea2D/SwordCollisionShape2D.disabled = false


func _on_PlayerNearArea2D_area_exited(area: Area2D) -> void:
	if area.name == 'CollisionEnemy' and not(die):
		$AnimatedSprite.play("walk");
		set_physics_process(true);
		$SwordArea2D/SwordCollisionShape2D.disabled = true
		
func _direction_move():
	
	if (player == null):
		return 
		
	var distance = player.global_position - global_position
	var direction = distance.normalized()
	
	if (abs(distance.x) <= 30):
		$AnimatedSprite.play("idle")
		_velocity.x = 0
	else:
		$AnimatedSprite.play("walk")
		_velocity.x = speed.x * sign(distance.x)
		$SwordArea2D/SwordCollisionShape2D.position.x = abs($SwordArea2D/SwordCollisionShape2D.position.x) * sign(distance.x)
		$PlayerNearArea2D/PlayerNearCollisionShape2D.position.x = abs($PlayerNearArea2D/PlayerNearCollisionShape2D.position.x) * sign(distance.x)
		$CollisionShape2D.position.x = abs($CollisionShape2D.position.x) * sign(distance.x)
		$AttackPlayerArea2D/AttackPlayerCollision.position.x = abs($AttackPlayerArea2D/AttackPlayerCollision.position.x) * sign(distance.x)
		
func die():
	die = true
	set_physics_process(false)
	$AnimatedSprite.play("death")

