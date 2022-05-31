extends KinematicBody2D


var speed: = Vector2(50.0, 0)

var _velocity = Vector2.ZERO
const FLOOR_NORMAL: = Vector2.UP
var gravity = 2000


#const SHOOT = preload("res://src/Objects/BombShoot.tscn")
const SHOOT = preload("res://src/Objects/BombGoblin.tscn")

func _ready() -> void:
	$TimerBomb.start(rand_range(1,4))
	set_physics_process(false)
	_velocity.x = -speed.x
	
	

func _physics_process(delta: float) -> void:
	
	if not($DetectorNearBorder.is_colliding()):
		_velocity.x = sign(_velocity.x) * -1 * speed.x
		$AnimatedSprite.flip_h = not($AnimatedSprite.flip_h)
		$DetectorNearBorder.position *= -1
	
	$Position2D.position.x = sign(_velocity.x) * abs($Position2D.position.x)
	
	_velocity.y += gravity * delta
	
	_velocity.y = move_and_slide(_velocity, FLOOR_NORMAL).y



func _on_TimerBomb_timeout() -> void:
	set_physics_process(false)
	$AnimatedSprite.play("attack3")
	
	


func _on_AnimatedSprite_animation_finished() -> void:
	if ($AnimatedSprite.animation == "attack3"):
		"""
		var bomb_goblin_instance = SHOOT.instance()
		bomb_goblin_instance.get_node("AnimatedSprite").play("shoot")
		bomb_goblin_instance.set_direction_shoot(sign($Position2D.position.x))
		bomb_goblin_instance.position = $Position2D.global_position
		get_parent().add_child(bomb_goblin_instance)
		bomb_goblin_instance.get_node('TimerExplode').start(2)
		"""
		set_physics_process(true)
		$AnimatedSprite.play("run")
	elif ($AnimatedSprite.animation == "death"):
		queue_free()

func _on_AnimatedSprite_frame_changed() -> void:
	if $AnimatedSprite.animation == "attack3" and $AnimatedSprite.frame == 11:
		var bomb_goblin_instance = SHOOT.instance()
		bomb_goblin_instance.get_node("AnimatedSprite").play("shoot")
		bomb_goblin_instance.set_direction_shoot(sign($Position2D.position.x))
		bomb_goblin_instance.position = $Position2D.global_position
		get_parent().add_child(bomb_goblin_instance)
		bomb_goblin_instance.get_node('TimerExplode').start(1)
		

func _on_StomArea_area_entered(area: Area2D) -> void:
	if (area.name == 'SwordArea'):
		_die()


func _on_CollisionEnemyAre_body_entered(body: Node) -> void:
	if (body.name == 'Player'):
		body.take_attack()
		
func _die():
	$AnimatedSprite.play("death")
