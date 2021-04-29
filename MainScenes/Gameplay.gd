extends Node2D

#preloading enemies and healthpacks
var plImp := preload("res://Imps/Imp.tscn")
var plHealth := preload("res://Healthpack/Healthpack.tscn")

#initializes the restarttimer for the function
onready var restartTimer = $restartTimer

#base amount of health for imps and starting spawn amount
var numImps = 6
var impLife = 4
var speedMult = 1.3

#tracks current wave
var currentWave = 1

#tracks total health of player
export var health = 100

var alreadyDead = false


# Spawn positions for new imps
var spawnPos := Vector2(0,120)
export var spawnXMin = 250
export var spawnXMax = 800

#variable for gameover
var lost = false

# Called when the node enters the scene tree for the first time.
func _ready():
	
	#start by spawning bois
	spawnImpies()
	
	
	
func _process(delta):
	
	#on restart button being pressed restart the game:
	if Input.is_action_pressed("restart"):
		get_tree().reload_current_scene()
		
	
	#on death show game over and remove all players from the screen
	if health <= 0:
		
		#we only want to play the death sound once, so we have a boolean
		if(alreadyDead == false):
			#we play the deathsound and set the boolean to true so it doesnt
			#play again
			$getsDeadSound.play()
			alreadyDead = true
		
		#make sure health cant go below 0
		health = 0
		get_node("GameOver").visible = true
		lost = true
		
		#gets rid of all enemies on screen
		for child in get_tree().get_nodes_in_group("damageable"):
			child.queue_free()
		
		

func _physics_process(delta):
	
	#if there are no other enemies remaining and we havent lost yet
	if get_tree().get_nodes_in_group("damageable").size() == 0 and lost == false:
		
		
		#increase firerate as levels continue
		if get_node("Doomguy").fireDelay >= .25:
			get_node("Doomguy").fireDelay -= .01
		#also increases spped by 10 each round up to 600
		if get_node("Doomguy").speed <= 600:
			get_node("Doomguy").speed += 10
		
		#increment the wave
		currentWave += 1
		#increment number of imps per wave (max 20)
		if numImps <= 25:
			numImps += rand_range(0, 2)
		
		#spawn the bois
		spawnImpies()
		
		
#spawns health pack for player
func spawnHealth():
	
	#this creates the health pack object
	var health := plHealth.instance()
	
	#then then choose left or right based on rng
	var leftOrRight = rand_range(1,2)
	var healthPos
	
	#from there we make the health position this based on rng
	if leftOrRight < 1.5:
		healthPos = Vector2(60,450)
	else:
		healthPos = Vector2(960,450)
	
	#set the global position and spawn it in
	health.global_position = healthPos
	get_tree().current_scene.add_child(health)

func spawnImpies():
	
	#increase speed of imps
	if currentWave%5 == 0 and speedMult <= 3:
		speedMult += .1
	
	#increase health of imps
	if currentWave%10 == 0:
			spawnHealth()
			impLife += 1
			
	#then we iterate over the number of imps
	for n in numImps:
			
			#randomize the starting x position
			spawnPos.x = rand_range(spawnXMin, spawnXMax)
			
			#create an imp based on the plImp
			var imp := plImp.instance()
			#set the start position
			imp.global_position = spawnPos
			
			#we then increase the base life based on the level
			imp.life = impLife
			#we also increase speed based on the speedMult
			imp.speed *= speedMult
			
			#add the imp to the scene
			get_tree().current_scene.add_child(imp)
	
#if the player is hurt in any way (either by collission with doomguy or statusbar
#then we take damage and play the damage sound
func playerHurt():
	health -= 5
	$getsHurtSound.play()
	
#if the player heals then we play the sound
func playerHeal():
	
	$healthPickupSound.play()
	
	#increase health by 25
	health += 25
	
	#max health is 200
	if (health >= 200):
		health = 200
	
func impDies():
	$impDeathSound.play()
	


func _on_backgroundMusic_finished():
	$backgroundMusic.play()
