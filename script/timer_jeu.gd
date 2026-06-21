extends Node

var temps_ecoule : float = 0.0
var DUREE := 180.0  # 3 minutes
var en_cours : bool = false

func demarrer():
	temps_ecoule = 0.0
	en_cours = true

func arreter():
	en_cours = false

func _process(delta):
	if not en_cours:
		return
	temps_ecoule += delta
	if temps_ecoule >= DUREE:
		en_cours = false
		get_tree().change_scene_to_file("res://scenes/bien_joue.tscn")
