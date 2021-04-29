extends Area2D

export var speed: float = 600

#the slug simply moves up at the speed provided
func _physics_process(delta):
	position.y -= speed * delta
	
	
#in the event that it exits the screen then we want it to dissappear
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


#on collision with enemy
func _on_Slug_area_entered(area):
	if area.is_in_group("damageable"):
		#we inflict the object we collide withs damage function for 1
		area.damage(1)
		#we then delete the explosion
		queue_free()
