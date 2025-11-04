extends CharacterBody2D

@export var speed = 100
@export var acceleration = 1500
@export var friction = 1000
@export var player: CharacterBody2D

var screen_size
var target_velocity = Vector2.ZERO

func _ready():
	screen_size = get_viewport_rect().size
	
func _physics_process(delta):
	var moveResult = move(delta)
	velocity = moveResult[0];
	move_and_slide()
	animate(velocity)
	queue_redraw()
	

# Returns an input_vector that has been influenced by input, acceleration, friction etc...
func move(delta: float):
	var input_vector = position.direction_to(player.position)
		
	target_velocity = input_vector * speed
	
	input_vector = velocity.move_toward(target_velocity, acceleration * delta)
		
	return [input_vector, target_velocity]
	
func animate(input_vector: Vector2):
	if (input_vector.x != 0):
		$AnimatedSprite2D.flip_h = input_vector.x < 0
	if input_vector.length() > 0:
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()

func _draw():
	# Draw current velocity in red
	draw_line(Vector2.ZERO, velocity * 0.15, Color.RED, 2)
	# Draw target velocity in green
	draw_line(Vector2.ZERO, target_velocity * 0.15, Color.GREEN, 2)
