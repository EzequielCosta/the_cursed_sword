extends RigidBody2D


const SPEED = -300
var velocity = Vector2.ZERO
var direction = -1
var gravity_bomb = 300

func set_direction_shoot (dir) :
	direction = dir * -1
	if dir == 1:
		$AnimatedSprite.flip_h = false
		
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$SoundFuseBomb.play()
	

func calculate_arc_velocity(source_position, target_position, arc_height, gravity):
	var velocity = Vector2()
	var displacement = target_position - source_position
	
	if displacement.y > arc_height:
		var time_up = sqrt(-2 * arc_height / float(gravity))
		var time_down = sqrt(2 * (displacement.y - arc_height) / float(gravity))
		print("time %s" % (time_up + time_down))
		
		velocity.y = -sqrt(-2 * gravity * arc_height)
		velocity.x = displacement.x / float(time_up + time_down) 
	
	return velocity


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	linear_velocity.x = abs(linear_velocity.x) * direction * -1
	#velocity.x =  SPEED * direction
	pass
	#linear_velocity = velocity
	#velocity.x = delta * SPEED * direction
	#velocity.y += gravity_bomb * delta
	#translate(velocity)


func _on_TimerExplode_timeout() -> void:
	$AnimatedSprite.play("explode")
	$SoundExplosion.play()
	$ExploseArea/ExploseAreaCollision.disabled = false


func _on_AnimatedSprite_animation_finished() -> void:
	if ($AnimatedSprite.animation == "explode"):
		queue_free()


func _on_ExploseArea_body_entered(body: Node) -> void:
	if body.name == "Player":
		body.take_attack()
