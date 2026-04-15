
;; script: fennel 


;;==========================================
;;1.Etats du jeu (RAM)
;;==========================================
(var couleur-fond 0) ;;0=Noir
(var couleur-texte 6 );;0=vert 

(global etat-jeu "accueil");;"etat-jeu" prendra plus tard "jeu" ou "accueil"
(global timer 0)           ;; l'horloge système pour les animations

(global player {:x 120 :y 10 :vy 0}) ;;le virus et vy la vellocité cad vitesse 
;;(global pare-feu {:x 240 :y 128 :vx -2}) ;;la vitesse de deplacement vers la gauche 
(global score 0)
(global plateforme1 {:x 100 :y 100 :w 40})

;;===========================================
;;2.Boucle principale (60 fps)
;;===========================================
(fn _G.TIC []
  ;;Pour chaque frame le timer doit être incrémenté
  (set timer (+ timer 1))
  
  ;;============================================
  ;;Maintenant on passe à l'etat du mode de jeu 
  (if ( = etat-jeu "accueil");;on est sur la page d'accueil alors 
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
      (print ">> PRESS W TO INITIATE << " 50 90 couleur-texte) )
    
    ;;Transition : Si on appuie sur le bouton Z (qui est 4 sur TIC-80)
    (if (btn 4)
      (set etat-jeu "jeu"))
    )
    (do;; le cas où on est sur l'ecran d'accueil et etant donné qu'on est dans une boucle etat-jeu peut changer 
      ;;-------------------------------------------
      ;;Ecran de jeu 
      ;;-------------------------------------------
      (cls couleur-fond )
      ;;-===========système de gravité==========::
      (if (btn 3);;btn 3 c'est l droite
        (set player.x (+ player.x 1))
      )
      (if (btn 2);;btn 2 button de gauche 
        (set player.x (- player.x 1))
      )
      (if (< player.x 0) (set player.x 0))
      (if (> player.x 240) (set player.x 240))  
     ;;fonction de saut 
      (set player.vy (+ player.vy 0.5))
      (set player.y (+ player.y player.vy))
      
      (print ">_" player.x  player.y  couleur-texte)

      ;;======systeme de saut et de colision===========
      ;; 1. On part du principe qu'on est en l'air au début de chaque image
      (var au-sol false)

      ;; 2. Collision avec Plateforme 1 (Seulement si on descend !)
      (if (and (> player.vy 0)          ;; <--- AJOUT : On vérifie qu'on chute
               (>= player.y plateforme1.y) 
               (< player.y (+ plateforme1.y 10)) ;; <--- OPTIONAL : Tolérance de 10 pixels
               (> player.x plateforme1.x) 
               (< player.x (+ plateforme1.x plateforme1.w)))
        (do
          (set player.y plateforme1.y) 
          (set player.vy 0)   
          (set au-sol true)
        )
      )
      ;; 2b. Choc par le dessous (La tête tape le plafond)
      (if (and (< player.vy 0)                            ;; 1. Si on est en train de monter
               (<= player.y (+ plateforme1.y 10))         ;; 2. Et que la tête touche le bas de la brique (épaisseur de 10)
               (> player.y plateforme1.y)                 ;; 3. (Sécurité pour ne pas bugger si on est au-dessus)
               (> player.x plateforme1.x)                 ;; 4. Et qu'on est bien aligné à gauche
               (< player.x (+ plateforme1.x plateforme1.w))) ;; 5. Et bien aligné à droite
        (do
          (set player.y (+ plateforme1.y 10))             ;; Action A : On repousse le perso pile sous la brique
          (set player.vy 0)                               ;; Action B : On stoppe l'élan, la gravité va faire le reste !
        )
      )


      ;; 3. Collision avec le Sol global
      (if (> player.y 128)
        (do
          (set player.y 128)
          (set player.vy 0)
          (set au-sol true) ;; <--- LE CAPTEUR S'ACTIVE AUSSI
        )
      )

      ;; 4. Le Saut Universel
      (if (and au-sol (btnp 4)) ;; Plus besoin de vérifier 128, on vérifie juste le capteur !
        (do 
          (set player.vy -7)
        )
      )
      ;;==========================================
      ;;Le mini obstacle (pare feu)
      ;;(set pare-feu.x (+ pare-feu.x pare-feu.vx))
      ;;(if (< pare-feu.x -10)
      ;;(do
        ;;(set pare-feu.x 240 )
        ;;(set score (+ score 10))
      ;;)
      ;;)
      (print (.. "SCORE : " score) 5 5 couleur-texte )
      ;;(print "[#]" pare-feu.x pare-feu.y  2) ;;rouge=2
      (print "=======" plateforme1.x plateforme1.y couleur-texte)

      ;;(if (and (< pare-feu.x (+ player.x 10)) (> pare-feu.x (- player.x 10)) (> player.y 120))
        ;;(do
          ;;(set etat-jeu "accueil")
          ;;(set score 0 )
        ;;)
      ;;)


    )
  )
)



  