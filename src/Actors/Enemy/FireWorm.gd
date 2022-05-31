extends KinematicBody2D

var speed: = Vector2(25.0, 0)
var _velocity = Vector2.ZERO
const FLOOR_NORMAL: = Vector2.UP
var gravity = 2000

const SHOOT = preload("res://src/Objects/ShootFireWorm.tscn")

func _ready() -> void:
	set_physics_process(false)
	_velocity.x = -speed.x
	
func _physics_process(delta: float) -> void:
	_velocity.y += gravity * delta
	if is_on_wall():
		$Position2D.position.x *= sign($Position2D.position.x)
	_velocity.x *= -1 if is_on_wall() else 1
	$AnimatedSprite.flip_h = _velocity.x < 0
	_velocity.y = move_and_slide(_velocity, FLOOR_NORMAL).y
	
	

func _on_TimerShoot_timeout() -> void:
	$AnimatedSprite.play("attack")

func _on_AnimatedSprite_animation_finished() -> void:
	if $AnimatedSprite.animation == "attack":
		$AnimatedSprite.play("walk")
	elif $AnimatedSprite.animation == "death":
		queue_free()


func _on_AnimatedSprite_frame_changed() -> void:
	if $AnimatedSprite.animation == "attack" and $AnimatedSprite.frame == 11:
		_createFireBall()
		
func _createFireBall() -> void :
	var shoot_fire_worm_instance = SHOOT.instance()
	shoot_fire_worm_instance.get_node("AnimatedSprite").play("move")
	shoot_fire_worm_instance.set_direction_shoot(sign($Position2D.position.x))
	shoot_fire_worm_instance.position = $Position2D.global_position
	get_parent().add_child(shoot_fire_worm_instance)


func _on_StompArea2D_area_entered(area: Area2D) -> void:
	if (area.name == 'SwordArea'):
		die()
		
func die():
	$AnimatedSprite.play("death")


func _on_VisibilityEnabler2D_screen_entered() -> void:
	$TimerShoot.start(4)
