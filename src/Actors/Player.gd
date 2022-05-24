extends KinematicBody2D

var speed: = Vector2(200.0, 700.0)
var _velocity = Vector2(0, 0)
var gravity = 2000

const FLOOR_NORMAL: = Vector2.UP

func _physics_process(delta: float) -> void:
	
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
		$SwordArea/CollisonSword.disabled = false
		$AnimatedSprite.play("attack")
	else:
		_velocity.x = 0
	
	_velocity.y = move_and_slide(_velocity, FLOOR_NORMAL).y
	
	if sign(_velocity.x) == 1:
		$SwordArea/CollisonSword.position.x = 1 * abs($SwordArea/CollisonSword.position.x)	
	elif sign(_velocity.x) == -1:
		$SwordArea/CollisonSword.position.x = -1 * abs($SwordArea/CollisonSword.position.x)		
	#$SwordArea/CollisonSword.position.x = sign(_velocity.x) * abs($SwordArea/CollisonSword.position.x)


func _on_EnemyDetector_body_entered(body: Node) -> void:
	
	if not(body.is_in_group("Enemy")):
		return
	
	GameManager.life_player -= 1
	if not(GameManager.life_player):
		queue_free();
	#f body.is_in_group("Enemy"):
		#rint("atingido por " + body.name)
	#$AnimatedSprite.play("hit")
	$AnimatedSprite.modulate = "#db2c2c"
	#set_physics_process(false)
	$Timer.start(1)
	
	#queue_free()


func _on_Timer_timeout() -> void:
	$AnimatedSprite.play("idle")
	#set_physics_process(true)
	$AnimatedSprite.modulate = "#fff"
	


func _on_AnimatedSprite_animation_finished() -> void:
	if ($AnimatedSprite.animation == "attack"):
		$SwordArea/CollisonSword.disabled = true;
		$AnimatedSprite.play("idle")
		#$AnimatedSprite.animation = "run"
		#$AnimatedSprite.frame = 0
	elif ($AnimatedSprite.animation == "run"):
		$AnimatedSprite.play("idle")
	elif ($AnimatedSprite.animation == "jump"):
		$AnimatedSprite.play("idle")
	


func _on_CollisionEnemy_area_entered(area: Area2D) -> void:
	
	"""
	$AnimatedSprite.modulate = "#db2c2c"
	GameManager.life_player -= 1
	if not(GameManager.life_player):
		queue_free();
	$AnimatedSprite.play("hit")
	self.modulate = "#fff";
	set_physics_process(false)
	$Timer.start(1)
	"""	


func _on_AnimatedSprite_frame_changed() -> void:
	if ($AnimatedSprite.animation == "attack" and $AnimatedSprite.frame >= 2):
		$SwordArea/CollisonSword.disabled = false;


func _on_SwordArea_body_entered(body: Node) -> void:
	body.queue_free();
