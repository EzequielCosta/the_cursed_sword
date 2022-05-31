extends KinematicBody2D

const max_hp = 4
var speed: = Vector2(200.0, 700.0)
var _velocity = Vector2(0, 0)
var gravity = 2000
signal hp_change(new_value)

const FLOOR_NORMAL: = Vector2.UP

func _physics_process(delta: float) -> void:
	
	check_if_die()
	
	_velocity.y += gravity * delta
	
	
	if (Input.is_action_just_pressed("jump") and is_on_floor()):
		$AnimatedSprite.play("jump")
		_velocity.y = -speed.y	
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
		$AnimatedSprite.speed_scale = 5
	else:
		_velocity.x = 0
		
	
	
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
	$AnimatedSprite.speed_scale = 3
	if ($AnimatedSprite.animation == "attack1"):
		$SwordArea/CollisonSword.disabled = true;
		$AnimatedSprite.play("idle")
	elif ($AnimatedSprite.animation == "run"):
		$AnimatedSprite.play("idle")
	elif ($AnimatedSprite.animation == "jump"):
		$AnimatedSprite.play("idle")
	elif ($AnimatedSprite.animation == "death"):
		GameManager.life_player = max_hp
		get_tree().change_scene("res://src/UI/GameOver.tscn")
	elif ($AnimatedSprite.animation == "hit"):
		#print('HIT')
		$AnimatedSprite.play("idle")
	


func _on_CollisionEnemy_area_entered(area: Area2D) -> void:
	if (area.is_in_group("Object_Enemy")):
		take_attack()


func _on_AnimatedSprite_frame_changed() -> void:
	if ($AnimatedSprite.animation == "attack1" and $AnimatedSprite.frame >= 4):
		$SwordArea/CollisonSword.disabled = false;


func _on_SwordArea_body_entered(body: Node) -> void:
	pass
	#if body.is_in_group("Enemy"):
		#body.queue_free()
	
func take_attack():
		
	GameManager.life_player -= 0.5
	emit_signal("hp_change", GameManager.life_player)
	
		
	$AnimatedSprite.play("hit")
	set_physics_process(false)
	$Timer.start(0.1)
	
func check_if_die():
	
	if GameManager.life_player == 0:
		$AnimatedSprite.play("death")
		return true
	return false
	
func set_hp(new_value):
	GameManager.life_player = new_value
	emit_signal("hp_change", new_value)
	

