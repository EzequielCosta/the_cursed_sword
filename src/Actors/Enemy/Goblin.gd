extends KinematicBody2D


var speed: = Vector2(50.0, 0)

var _velocity = Vector2.ZERO
const FLOOR_NORMAL: = Vector2.UP
var gravity = 2000


const SHOOT = preload("res://src/Objects/BombShoot.tscn")

func _ready() -> void:
	$TimerBomb.start(3)
	set_physics_process(false)
	_velocity.x = -speed.x
	
	

func _physics_process(delta: float) -> void:
	#print(_velocity.x)
	#print(sign(_velocity.x))
	if not($DetectorNearBorder.is_colliding()):
		_velocity.x = sign(_velocity.x) * -1 * speed.x
		$AnimatedSprite.flip_h = not($AnimatedSprite.flip_h)
		$DetectorNearBorder.position *= -1
	
	$Position2D.position *= sign(_velocity.x)
	
	_velocity.y += gravity * delta
	
	_velocity.y = move_and_slide(_velocity, FLOOR_NORMAL).y



func _on_TimerBomb_timeout() -> void:
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
		$AnimatedSprite.play("run")




func _on_AnimatedSprite_frame_changed() -> void:
	if $AnimatedSprite.animation == "attack3" and $AnimatedSprite.frame == 11:
		var bomb_goblin_instance = SHOOT.instance()
		bomb_goblin_instance.get_node("AnimatedSprite").play("shoot")
		bomb_goblin_instance.set_direction_shoot(sign($Position2D.position.x))
		bomb_goblin_instance.position = $Position2D.global_position
		get_parent().add_child(bomb_goblin_instance)
		bomb_goblin_instance.get_node('TimerExplode').start(2)
