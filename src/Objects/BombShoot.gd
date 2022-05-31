extends RigidBody2D

const SPEED = -200
var velocity = Vector2.ZERO
var direction = -1
var gravity_bomb = 100

func set_direction_shoot (dir) :
	direction = dir * -1
	if dir == 1:
		$AnimatedSprite.flip_h = false
		
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	
	#velocity.x = delta * SPEED * direction
	velocity.x =  SPEED * direction
	velocity.y += gravity_bomb * delta
	#var collision = move_and_collide(velocity * delta)
	#if collision != null:
		#on_impact(collision.normal)
	#translate(velocity)
	
func on_impact(normal : Vector2):
	velocity = velocity.bounce(normal)
	velocity *= 0.5 + rand_range(-0.05, 0.05)


func _on_TimerExplode_timeout() -> void:
	$AnimatedSprite.play("explode")
	$AreaExplosion.disabled = false


func _on_AnimatedSprite_animation_finished() -> void:
	if $AnimatedSprite.animation == "explode":
		queue_free()
