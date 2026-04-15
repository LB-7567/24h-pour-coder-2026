
;; script: fennel 


;;==========================================
;;1.Etats du jeu (RAM)
;;==========================================
(var couleur-fond 0) ;;0=Noir
(var couleur-texte 6 );;0=vert 

(global etat-jeu "acceuil");;"etat-jeu" prendra plus tard "jeu" ou "acceuil"
(global timer 0)           ;; l'horloge système pour les animations

;;===========================================
;;2.Boucle principale (60 fps)
;;===========================================
(fn _G.TIC []
  ;;Pour chaque frame le timer doit être incrémenté
  (set timer (+ timer 1))
  
  ;;============================================
  ;;Maintenant on passe à l'etat du mode de jeu 
  (if ( = etat-jeu "acceuil");;on est sur la page d'acceuil alors 
    (do
    ;;------------------------------------------
    ;;Ecran de jeu 
    ;;------------------------------------------
    (cls couleur-fond)
    ;;Titre-principal 
    (print "HACK THE SYSTEM " 65 40 11);; dans l'ordre l'abscisse 65 l'ordonné 40 et la couleur 11=cyan
    (print "v1.0.0_beta" 100 50 couleur-texte)
    ;;Pour faire clignoter le texte toutes les 30 frames
    (if (= (% (// timer 30) 2) 0)
      (print ">> PRESS Z TO INITIATE << " 50 90 couleur-texte) )
    
    ;;Transition : Si on appuie sur le bouton Z (qui est 4 sur TIC-80)
    (if (btn 4)
      (set etat-jeu "jeu"))
    )
    (do;; le cas où on est sur l'ecran d'acceuil et etant donné qu'on est dans une boucle etat-jeu peut changer 
      ;;-------------------------------------------
      ;;Ecran de jeu 
      ;;-------------------------------------------
      (cls couleur-fond )
      (print "SYSTÈME COMPROMIS." 5 5 2) ;;2=Rouge foncé
      (print "Charement de la gravité." 5 15 couleur-texte)

    )
  )
)



  