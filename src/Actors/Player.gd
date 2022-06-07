extends KinematicBody2D


const max_hp = 4
var speed: = Vector2(200.0, 700.0)
var _velocity = Vector2(0, 0)
var gravity = 2000
var impulse:float = 600.0
signal hp_change(new_value)
var _die:bool = false
const FLOOR_NORMAL: = Vector2.UP



func _physics_process(delta: float) -> void:
	
	if _die:
		return
	
	_velocity.y += gravity * delta
	
	if (Input.is_action_just_pressed("jump") and is_on_floor()):
		$AnimatedSprite.play("jump")
		_velocity.y = -speed.y	
	not(Input.is_action_pressed("move_right")) and not(Input.is_action_pressed("move_left")) and $SoundRun.stop()
	(Input.is_action_pressed("move_right") or Input.is_action_pressed("move_left")) and not(is_on_floor()) and $SoundRun.stop()
	
	if (Input.is_action_just_pressed("move_right") or Input.is_action_just_pressed("move_left")) and is_on_floor():
		$SoundRun.play()
		
	if (Input.is_action_pressed("move_right")):
		$AnimatedSprite.play("run")
		_velocity.x = speed.x
		$AnimatedSprite.flip_h = false
	elif (Input.is_action_pressed("move_left")):
		$AnimatedSprite.play("run")
		$AnimatedSprite.flip_h = _velocity.x < 0
		_velocity.x = -speed.x
	elif (Input.is_action_just_pressed("attack")):
		$AnimatedSprite.play("attack1")
		#$AnimatedSprite.speed_scale = 3
	else:
		_velocity.x = 0
		
	#var screen_size = get_viewport_rect().size
	#position.x = clamp(position.x, 0, screen_size.x)
	
	_velocity.y = move_and_slide(_velocity, FLOOR_NORMAL).y
	
	if sign(_velocity.x) == 1:
		$SwordArea/CollisonSword.position.x = 1 * abs($SwordArea/CollisonSword.position.x)	
	elif sign(_velocity.x) == -1:
		$SwordArea/CollisonSword.position.x = -1 * abs($SwordArea/CollisonSword.position.x)		
	


func _on_EnemyDetector_body_entered(body: Node) -> void:
	
	if not(body.is_in_group("Enemy")):
		return
	#print("_on_EnemyDetector_body_entered")
	take_attack()
	

func _on_Timer_timeout() -> void:
	set_physics_process(true)
	

func _on_AnimatedSprite_animation_finished() -> void:
	$SwordArea/CollisonSword.disabled = true;
	$AnimatedSprite.speed_scale = 3
	if ($AnimatedSprite.animation == "attack1"):
		$AnimatedSprite.play("idle")
	elif ($AnimatedSprite.animation == "run"):
		$AnimatedSprite.play("idle")
	elif ($AnimatedSprite.animation == "jump"):
		$AnimatedSprite.play("idle")
	elif ($AnimatedSprite.animation == "death"):
		GameManager.life_player = max_hp
		queue_free()
		get_tree().change_scene("res://src/UI/GameOver.tscn")
	elif ($AnimatedSprite.animation == "hit"):
		$AnimatedSprite.play("idle")
	


func _on_CollisionEnemy_area_entered(area: Area2D) -> void:
	if (area.is_in_group("Object_Enemy")):
		take_attack()


func _on_AnimatedSprite_frame_changed() -> void:
	if ($AnimatedSprite.animation == "attack1" and $AnimatedSprite.frame >= 4):
		$SwordArea/CollisonSword.disabled = false;
		$SoundAttack01.play()
	
func take_attack( damage_value: int = 0.5):
	
	if _die:
		return
		
	GameManager.life_player -= damage_value
	emit_signal("hp_change", GameManager.life_player)
	
	if check_if_die():
		return
		
	$SoundHit.play()	
	$AnimatedSprite.play("hit")
	set_physics_process(false)
	$Timer.start(0.1)
	
func check_if_die():
	
	if GameManager.life_player == 0:
		_die = true
		die()
		return true
	return false
	
func die():
	set_physics_process(false)
	$CollisionEnemy/CollisionShape2D.disabled = true
	$CollisionShape2D.disabled = true
	$AnimatedSprite.speed_scale = 2
	$SoundDeath.play()
	$AnimatedSprite.play("death")
	
func set_hp(new_value):
	GameManager.life_player = new_value
	emit_signal("hp_change", new_value)
	
func impulse_jump(value):
	_velocity = Vector2(_velocity.x, -value)
	



func _on_StompJumpEnemy_area_entered(area: Area2D) -> void:
	if (area.name == "StompJumpArea"):
		impulse_jump(impulse)


func _on_SoundDeath_finished() -> void:
	pass
	"""
	GameManager.life_player = max_hp
	queue_free()
	get_tree().change_scene("res://src/UI/GameOver.tscn")
	"""

func get_die():
	return _die
