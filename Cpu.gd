extends Node

signal cpu_dead

var health
var action
var ammo

func choose():
	var hasChosen = false
	while not hasChosen:
		var num_aleatorio = RandomNumberGenerator.new()
		var option = num_aleatorio.randi_range(1,3)
		match option:
			1:
				if ammo == 1:
					ammo = 0
					hasChosen = true
					action = "shoot"
				else:
					hasChosen = false
			2:
				action = "shield"
				hasChosen = true
			3:
				if ammo == 0:
					ammo = 1
					hasChosen = true
					action = "reload"
				else:
					ammo = 1
					hasChosen = false
	return action


func takeDamage():
	health -= 1
	if health <= 0:
		cpu_dead.emit()


func new_game():
	health = 3
	action = ""
	ammo = 0
