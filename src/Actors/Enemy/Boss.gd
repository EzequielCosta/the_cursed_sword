extends KinematicBody2D


var speed: = Vector2(100.0, 0)

var _velocity = Vector2.ZERO
const FLOOR_NORMAL: = Vector2.UP
var gravity = 2000
onready var player : Node2D
var distance_old_player;
signal hp_change(new_value)
signal turn_night(night)
signal die()

#const SHOOT = preload("res://src/Objects/BombShoot.tscn")
const SHOOT = preload("res://src/Objects/BombGoblin.tscn")

func _ready() -> void:
	set_physics_process(false)
	$TimerBomb.start(10)
	$TimerAttack2.start(15)
	_velocity.x = -speed.x
	player = get_parent().get_node("Player")
	
	

func _physics_process(delta: float) -> void:
	
	player =  get_parent().get_node("Player")
	var direction:float =  directionOfPlayer()
	_velocity.x =  abs(_velocity.x) * direction 
	
	_collision_wall()
	_define_direction(direction)
	
	$AnimatedSprite.flip_h = _velocity.x < 0
		
	_velocity.y += gravity * delta
	_velocity.y += gravity * delta
	_velocity.y = move_and_slide(_velocity, FLOOR_NORMAL).y



func _on_TimerBomb_timeout() -> void:
	set_physics_process(false)
	$AnimatedSprite.play("attack1")
	
	


func _on_AnimatedSprite_animation_finished() -> void:
	if ($AnimatedSprite.animation == "attack1"):
		set_physics_process(true)
		$AnimatedSprite.play("run")
	elif ($AnimatedSprite.animation == "attack2"):
		set_physics_process(true)
		$AnimatedSprite.play("run")
		$SwordAttack2Area/SwordAttack2Collision.disabled = true
	elif ($AnimatedSprite.animation == "attack3"):
		$AnimatedSprite.speed_scale = 2
		$SwordAttack3Area/SwordAttack3Collision.disabled = true
		set_physics_process(true)
		$AnimatedSprite.play("run")
	elif ($AnimatedSprite.animation == "hit"):
		$SwordAttack2Area/SwordAttack2Collision.disabled = true
		$SwordAttack3Area/SwordAttack3Collision.disabled = true
		set_physics_process(true)
		
	
	elif ($AnimatedSprite.animation == "death"):
		emit_signal("die")
		queue_free()
		
	elif ($AnimatedSprite.animation == "hit"):
		$AnimatedSprite.play("idle")
		$AnimatedSprite.frame = 2
		#$TimerHit.start(0.5)
		set_physics_process(false)
		$StompArea/StompCollision.disabled = false
		

func _on_AnimatedSprite_frame_changed() -> void:
	
	if $AnimatedSprite.animation == "attack1" and $AnimatedSprite.frame == 11:
		var bomb_goblin_instance = SHOOT.instance()
		bomb_goblin_instance.get_node("AnimatedSprite").play("shoot")
		bomb_goblin_instance.set_direction_shoot(sign($Position2D.position.x))
		bomb_goblin_instance.position = $Position2D.global_position
		get_parent().add_child(bomb_goblin_instance)
		bomb_goblin_instance.get_node('TimerExplode').start(1)
	elif ($AnimatedSprite.animation ==  "attack2" and $AnimatedSprite.frame == 6):
		_attack2()
		#$AnimatedSprite.speed_scale = 2
		#$SwordAttack2Area/SwordAttack2Collision.disabled = false
	elif ($AnimatedSprite.animation == "attack3" and $AnimatedSprite.frame == 6):
		$SwordAttack3Area/SwordAttack3Collision.disabled = false
		$AnimatedSprite.speed_scale = 2
	elif ($AnimatedSprite.animation ==  "hit" and $AnimatedSprite.frame == 3):
		pass
		

func _on_StomArea_area_entered(area: Area2D) -> void:
	if (area.name == 'SwordArea'):
		_die()


func _on_CollisionEnemyAre_body_entered(body: Node) -> void:
	if (body.name == 'Player'):
		body.take_attack(0.5)
		
func _die():
	set_physics_process(false)
	$AnimatedSprite.play("death")


func _on_NearPlayerArea_body_entered(body: Node) -> void:
	if (body.name == 'Player'):
		set_physics_process(false)
		$AnimatedSprite.play("attack3")
		$AnimatedSprite.speed_scale = 1

func _on_StompArea_area_entered(area: Area2D) -> void:
	if (area.name == 'SwordArea'):
		if (GameManager.life_boss == 0):
			_die()
			return
		
		#set_physics_process(false)
		$AnimatedSprite.speed_scale = 3
		$AnimatedSprite.play("hit")
		$StompArea/StompCollision.disabled = true
		GameManager.life_boss -= 10
		emit_signal("hp_change", GameManager.life_boss)
		
		
func directionOfPlayer() -> float:
	
	if (player == null):
		return sign(_velocity.x)
	
	var distance: Vector2 = (player.global_position - global_position)
	var direction: Vector2 = distance.normalized()
	if (abs(distance.x) <= 10):
		$AnimatedSprite.play("idle")
		#$TimerAttack2.stop()
		#$TimerAttack3.stop()
		#$TimerBomb.stop()
		return 0.0
	else:
		$AnimatedSprite.play("run")
		#$TimerAttack2.start(10)
		#$TimerAttack3.start(20)
		#$TimerBomb.start(30)
		_velocity.x = direction.x * speed.x
	
	return sign(distance.x)
		
	

func _define_direction (direction:int) -> void:
	
	if direction != 0:
		$Position2D.position.x = direction * abs($Position2D.position.x)
		$NearPlayerArea/NearPlayerCollision.position.x = direction * abs($NearPlayerArea/NearPlayerCollision.position.x)
		$SwordAttack2Area/SwordAttack2Collision.position.x = abs($SwordAttack2Area/SwordAttack2Collision.position.x) * direction
		$SwordAttack3Area/SwordAttack3Collision.position.x = abs($SwordAttack3Area/SwordAttack3Collision.position.x) * direction
		

func _on_TimerAttack3_timeout() -> void:
	set_physics_process(false)
	$AnimatedSprite.speed_scale = 3
	$AnimatedSprite.play("attack3")


func _on_SwordAttack2Area_body_entered(body: Node) -> void:
	if (body.name == 'Player'):
		body.take_attack(1)


func _on_TimerAttack2_timeout() -> void:
	set_physics_process(false)
	$AnimatedSprite.speed_scale = 3
	$AnimatedSprite.play("attack2")


func _on_TimerHit_timeout() -> void:
	set_physics_process(true)
	$AnimatedSprite.play("run")
	$AnimatedSprite.speed_scale = 2
	


func _on_SwordAttack3Area_body_entered(body: Node) -> void:
	if (body.name == 'Player'):
		print(GameManager.life_player)
		body.take_attack(1)
		
func _collision_wall():
	
	if is_on_wall():
		$Position2D.position.x = sign(_velocity.x) * abs($Position2D.position.x)
		$NearPlayerArea/NearPlayerCollision.position.x = sign(_velocity.x) * abs($NearPlayerArea/NearPlayerCollision.position.x)
		$AnimatedSprite.flip_h = not($AnimatedSprite.flip_h)
	_velocity.x *= -1 if is_on_wall() else 1	

func _attack2():
	$AnimatedSprite.speed_scale = 2
	$SwordAttack2Area/SwordAttack2Collision.disabled = false


func _on_VisibilityEnabler2D_screen_entered() -> void:
	emit_signal("turn_night", true)


func _on_VisibilityEnabler2D_screen_exited() -> void:
	emit_signal("turn_night", false)
