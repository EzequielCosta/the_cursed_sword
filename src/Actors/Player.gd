extends KinematicBody2D

var speed: = Vector2(200.0, 700.0)
var _velocity = Vector2(0, 0)
var gravity = 2000

const FLOOR_NORMAL: = Vector2.UP

func _physics_process(delta: float) -> void:
	
	_velocity.y += gravity * delta
	#var direction = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	
		
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
		$AnimatedSprite.play("attack")
	else:
		_velocity.x = 0
		#$AnimatedSprite.frame = 10
		#$AnimatedSprite.stop()
		
	"""	
	if (!Input.is_action_just_pressed("jump") and is_on_floor()):
		$AnimatedSprite.play("run")	
	if (!is_on_floor() and _velocity.y > 0):
		print("ol")
		$AnimatedSprite.play("fall")
	"""
		
	
		
		#$AnimatedSprite.flip_h = _velocity.x < 0
		#_velocity.x = -speed.x
		
	_velocity.y = move_and_slide(_velocity, FLOOR_NORMAL).y
	#move_and_slide(_velocity, FLOOR_NORMAL)
	




func _on_EnemyDetector_body_entered(body: Node) -> void:
	#print("atingido")
	if body.is_in_group("Enemy"):
		print("atingido por " + body.name)
	#$AnimatedSprite.play("hit")
	#set_physics_process(false)
	#$Timer.start(1)
	
	#queue_free()


func _on_Timer_timeout() -> void:
	$AnimatedSprite.play("run")
	set_physics_process(true)
	


func _on_CollsionStomp_body_entered(body: KinematicBody2D) -> void:
	_velocity.y -= 200
	#body.queue_free()
	#body.get_node("AnimatedSprite").play("hit")
	#body.get_children("")$AnimatedSprite.play("hit")


func _on_AnimatedSprite_animation_finished() -> void:
	if ($AnimatedSprite.animation == "attack"):
		$AnimatedSprite.play("idle")
		#$AnimatedSprite.animation = "run"
		#$AnimatedSprite.frame = 0
	elif ($AnimatedSprite.animation == "run"):
	
		$AnimatedSprite.play("idle")
	


func _on_CollisionEnemy_area_entered(area: Area2D) -> void:
	print("Atingido ṕpor " + area.name)
	#queue_free();
