extends KinematicBody2D

var speed: = Vector2(30.0, 0)
var _velocity = Vector2.ZERO
const FLOOR_NORMAL: = Vector2.UP
var gravity = 2000

func _ready() -> void:
	set_physics_process(false)
	_velocity.x = -speed.x
	
func _physics_process(delta: float) -> void:
	_velocity.y += gravity * delta
	_velocity.x *= -1 if is_on_wall() else 1	
	$AnimatedSprite.flip_h = _velocity.x < 0
	_velocity.y = move_and_slide(_velocity, FLOOR_NORMAL).y
	
	


func _on_PlayerNearArea2D_body_entered(body: Node) -> void:
	if (body.name == "Player"):
		$AnimatedSprite.play("attack")
		set_physics_process(false);
		$SwordArea2D/SwordCollisionShape2D.disabled = false
		print("Atingido por esqueleto")
