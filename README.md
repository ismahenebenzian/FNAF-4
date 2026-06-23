# Midnight Terror

## À propos du jeu

**Midnight Terror** est un jeu d'horreur psychologique en vue subjective, inspiré de *Five Nights at Freddy's 4*.

Vous incarnez un enfant seul dans sa chambre, la nuit. Votre objectif est simple : **survivre jusqu'à 6h du matin** (environ 3 minutes dans cette version). Pour cela, vous devez surveiller les deux portes, le placard et le lit, tout en gérant vos ressources : votre lampe torche et les fermetures de portes.

Vous ne pouvez pas vous déplacer librement : vous passez d'une zone à l'autre en cliquant ou en glissant la souris. Chaque action a un prix : il faut constamment choisir où regarder, éclairer ou fermer pour ne pas se faire surprendre.

---

## Comment jouer

### Commandes

| Action | Touche / Souris |
|--------|----------------|
| Allumer la lampe torche | **Espace** (dans une vue rapprochée) |
| Fermer une porte (maintien) | **Clic gauche + maintenir** (dans une vue porte) |
| Regarder sous le lit | **Glisser la souris vers le bas** (depuis la vue principale) |
| Revenir à la vue principale | **Glisser la souris vers le bas** (depuis n'importe quelle vue rapprochée) |
| Ouvrir une porte / le placard | **Clic gauche** sur l'élément dans la vue principale |

### Les différentes vues

- **Vue principale (chambre)** : L'ambiance est très sombre. Utilisez la lampe pour entrevoir les portes et le placard. Glissez vers le bas pour regarder sous le lit.
- **Porte gauche / Porte droite** : Un clic sur une porte vous met en gros plan. Vous pouvez alors :
  - Appuyer sur **Espace** pour allumer la lampe et vérifier si le lapin est dans le couloir.
  - **Maintenir le clic** pour fermer la porte et bloquer le monstre.
  - Glisser vers le bas pour revenir en arrière.
- **Placard** : Même principe que les portes (lampe + fermeture).
- **Lit** : Accessible depuis la vue principale en glissant vers le bas. La lampe permet de voir si quelque chose s'y cache (non relié au système de monstres pour l'instant).

---

## Comportement du monstre

Actuellement, un seul monstre (le **lapin**) est géré. Il peut apparaître dans le **couloir gauche** ou le **couloir droit**.

- **Positions** :
  - `APPARITION` : le monstre est invisible (inactif).
  - `LOIN` : le monstre est au fond du couloir (vous pouvez apercevoir une ombre).
  - `DEVANT` : le monstre est juste derrière la porte, prêt à attaquer.

- **Déplacement** : Toutes les **10 secondes**, le monstre a **40 % de chances** de changer de position. Il apparaît d'abord au fond (`LOIN`), puis peut avancer jusqu'à la porte (`DEVANT`).

### Comment réagir ?

- **Lampe (Espace)** :
  - Si le monstre est `LOIN` → la lumière le **repousse** (il retourne à `APPARITION`).
  - Si le monstre est `DEVANT` → la lumière le **déclenche** : c'est la **défaite immédiate** (écran scream).

- **Fermeture de porte (clic maintenu)** :
  - Si le monstre est `DEVANT`, vous devez **maintenir la porte fermée pendant 3 secondes** pour le repousser.
  - Si vous relâchez trop tôt, le monstre reste derrière la porte et pourra attaquer plus tard.

---

## ⚠️ Attention : le son est votre meilleur allié !

Le jeu repose énormément sur l'audio :

- Dès que le monstre passe en position `DEVANT`, un **souffle inquiétant** se déclenche automatiquement.
- Ce son s'arrête dès que le monstre s'éloigne (retour à `APPARITION`).
- **Conseil** : jouez avec un casque ou des écouteurs. Si vous entendez un souffle, vous savez qu'une porte est en danger : réagissez vite !

---

## État actuel du projet (limites connues)

Ce projet est un travail étudiant. Certaines fonctionnalités ne sont pas encore finalisées :

- Seules les **portes gauche et droite** sont reliées au système de monstre.
- Les vues du **lit** et du **placard** sont présentes visuellement, mais **aucun monstre** ne s'y trouve pour le moment.
- Des améliorations futures pourront ajouter des menaces dans ces zones.

---

## Crédits

- **Ismahene Benzian** – Frontend (interfaces, affichage)  
- **Alric Guillotin** – Backend (logique, IA du monstre, gestion d'état)  
- **Camille Tripot** – Assemblage, sons et images  

---

## Outils utilisés

- **Godot 4** – Moteur de jeu gratuit et open-source  
- **GDScript** – Langage de programmation (proche du Python)  
- **GitHub** – Gestion de versions  
- **Trello** – Organisation des tâches

---

## Lancer le jeu

1. Clonez ce dépôt.
2. Ouvrez le projet avec **Godot 4**.
3. Lancez la scène principale : `MainRoom.tscn`.

---

**Bonne chance… et surtout, restez à l'écoute !** 👻
