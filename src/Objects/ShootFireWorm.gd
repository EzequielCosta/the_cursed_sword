extends Area2D


const SPEED = -100
var velocity = Vector2.ZERO
var direction = -1

func set_direction_shoot (dir) :
	direction = dir * -1
	if dir == 1:
		$AnimatedSprite.flip_h = false
		
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	velocity.x = delta * SPEED * direction
	translate(velocity)
