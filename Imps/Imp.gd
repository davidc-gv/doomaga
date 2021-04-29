extends Area2D

#this loads the scene of the death explosion so we can spawn it on death
var plExplosion = preload("res://Explosion/Explosion.tscn")

#speed of enemies are variable, this is our upper and lower bound for rng
export var minSpeed: float = 10
export var maxSpeed: float = 20

#we then initialize the imps life
export var life: int = 4

#and we initialize the speed
var speed: float = 0

#this function runs on initialization, we generate the speed based on up and lower bounds
func _ready():
	speed = rand_range(minSpeed, maxSpeed)

#each turn we move the enemy down based on speed
func _physics_process(delta):
	position.y += speed * delta
	
	#this increases the size of the imps as they get closer
	if($AnimatedSprite.scale.x <= 4):
	
		#this increases their scale by .01% per clock tick
		$AnimatedSprite.scale *= 1.001
		$CollisionPolygon2D.scale *= 1.001
	
	
	
#this happens in the event of getting hit
func damage(amount: int):
	#we take damage and play the sound per normal
	life -= amount
	$hurtSound.play()
	
	#this is where things get different, if we die then
	if life <= 0:
		
		#we create the explosion and play it
		var explode = plExplosion.instance()
		explode.global_position = global_position
		get_tree().current_scene.add_child(explode)
		explode.play()
		
		#however, since this is going away soon, we have to play the deathsound
		#outside of this function, otherwise it ends when the imp does
		#so we call the parent function to play this sound
		get_parent().impDies()
		
		#then we get rid of ourselves
		queue_free()
		
		
		

#this is rather unnecessary, if the imp leaves the viewable screen we remove it
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
