extends Node

enum Etat { SPAWN, COULOIR_GAUCHE_LOIN, COULOIR_GAUCHE_DEVANT, COULOIR_DROITE_LOIN, COULOIR_DROITE_DEVANT }

var etat : Etat = Etat.SPAWN
var timer_mouvement : float = 0.0
var DELAI := 3.0

func _process(delta):
	timer_mouvement += delta
	if timer_mouvement >= DELAI:
		timer_mouvement = 0.0
		_tenter_deplacement()

func _tenter_deplacement():
	if randf() > 0.4:
		return
	match etat:
		Etat.SPAWN:
			if randf() < 0.5:
				etat = Etat.COULOIR_GAUCHE_LOIN
			else:
				etat = Etat.COULOIR_DROITE_LOIN
		Etat.COULOIR_GAUCHE_LOIN:
			etat = Etat.COULOIR_GAUCHE_DEVANT
		Etat.COULOIR_DROITE_LOIN:
			etat = Etat.COULOIR_DROITE_DEVANT

func retour_spawn():
	etat = Etat.SPAWN
	timer_mouvement = 0.0
