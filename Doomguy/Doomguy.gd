extends Area2D

#this loads the scene of our slug so we can spawn more
var plSlug := preload("res://Slugs/Slug.tscn")

#this is where we declare our variables that are not immediately avaiable to the script
onready var firingPositions := $FiringPositions
onready var fireDelayTimer := $FireTimer

#speed is the speed of the player
var speed: float = 350
#the fireDelay is how long in between shots, smaller the number, faster shooting
var fireDelay: float = .55
#this technically isnt necessary since we move only in 1 direction, but its nice to have
var vel := Vector2(0,0)

#this function runs once per clock tick
func _process(delta):
	
	#this is our shooting logic
	if Input.is_action_pressed("shoot") and fireDelayTimer.is_stopped():
		
		#if we lose then we dont want to be able to shoot at the loss screen
		if get_parent().lost == false:
			
			#otherwise we get "firingpositions" children
			#firingpositions are the two barrels of the shotgun
			for child in firingPositions.get_children():
				#we then start a delaytimer so that we cannot shoot too quickly
				fireDelayTimer.start(fireDelay)
				
				#we initialize the slug, change its position, and add it to the scene
				var slug := plSlug.instance()
				slug.global_position = child.global_position
				get_tree().current_scene.add_child(slug)
				
				#lastly we play the firing sound
				$fireSound.play()
	

#this is the movement function
func _physics_process(delta):
	
	#we set our vel to 0 so we dont continue to slide
	vel.x = 0
	#we then change the velocity of x based on if we move right or left
	if Input.is_action_pressed("move-left"):
		vel.x = -speed
	elif Input.is_action_pressed("move-right"):
		vel.x = speed
		
	#much like unity, movement is based on our delta
	position += vel * delta
	
	#we then do this to ensure that any movement is within our viewport regardless of scaling
	var viewRect := get_viewport_rect()
	position.x = clamp(position.x, 19, viewRect.size.x - 19)


#if anything collides with doomguy then its an enemy
func _on_Doomguy_area_entered(area):
	#we get the object by its tag
	if area.is_in_group("damageable"):
		#we remove the object
		area.queue_free()
		#then we call the parent function to calculate damage
		get_parent().playerHurt()
	
	#now we check if its a health pack
	if area.is_in_group("healing"):
		#if so we remove the healthpack
		area.queue_free()
		#and we call the parent function to heal
		get_parent().playerHeal()
