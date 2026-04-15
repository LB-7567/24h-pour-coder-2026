
;; script: fennel 


;;==========================================
;; 1. Etats du jeu (RAM)
;;==========================================
(var couleur-fond 0)
(var couleur-texte 6)

(global etat-jeu "accueil")
(global timer 0)           

;; V2.0: Ajout de vx (vitesse horizontale), w (largeur hitbox), et au-sol directement dans le joueur !
(global player {:x 120 :y 10 :vx 0 :vy 0 :w 12 :au-sol false}) 
(global score 0)
(global plateforme1 {:x 100 :y 100 :w 40})

;;===========================================
;; 2. Boucle principale (60 fps)
;;===========================================
(fn _G.TIC []
  (set timer (+ timer 1))
  
  (if (= etat-jeu "accueil")
    (do
      ;;------------------------------------------
      ;; Ecran d'accueil 
      ;;------------------------------------------
      (cls couleur-fond)
      (print "HACK THE SYSTEM " 65 40 11)
      (print "v2.0.0_beta" 100 50 couleur-texte)
      (if (= (% (// timer 30) 2) 0)
        (print ">> PRESS W TO INITIATE << " 50 90 couleur-texte) )
      
      (if (btn 4)
        (set etat-jeu "jeu"))
    )
    (do
      ;;-------------------------------------------
      ;; Ecran de jeu (Moteur Physique V2)
      ;;-------------------------------------------
      (cls couleur-fond)
      
      ;; -- SAUVEGARDE DE L'ANCIENNE POSITION (Anti-traversée) --
      (var old-y player.y)

      ;; -- MOUVEMENT HORIZONTAL (Inertie + Friction) --
      (if (btn 3) (set player.vx (+ player.vx 0.5)))
      (if (btn 2) (set player.vx (- player.vx 0.5)))
      (set player.vx (* player.vx 0.8)) ;; pour que ça glisse 
      (set player.x (+ player.x player.vx))

      ;; -- LIMITES ECRAN (Prise en compte de la largeur du joueur) --
      (if (< player.x 0) (do (set player.x 0) (set player.vx 0)))
      (if (> player.x (- 240 player.w)) (do (set player.x (- 240 player.w)) (set player.vx 0)))

      ;; -- GRAVITE --
      (set player.vy (+ player.vy 0.5))
      (set player.y (+ player.y player.vy))
      
      (print ">_" player.x player.y couleur-texte)

      ;; -- COLLISIONS (Béton Armé) --
      (set player.au-sol false) ;; On réinitialise à chaque frame

      ;; Atterrissage (Pieds sur le toit)
      (if (and (> player.vy 0)          
               (<= old-y plateforme1.y)                  ;; On était au-dessus avant
               (>= player.y plateforme1.y)               ;; On est en dessous maintenant
               (> (+ player.x player.w) plateforme1.x)   ;; Hitbox Droite
               (< player.x (+ plateforme1.x plateforme1.w))) ;; Hitbox Gauche
        (do
          (set player.y plateforme1.y) 
          (set player.vy 0)   
          (set player.au-sol true)
        )
      )
      
      ;; Choc par le dessous (Tête dans le plafond)
      (if (and (< player.vy 0)                            
               (>= old-y (+ plateforme1.y 10))           ;; On était en dessous avant
               (<= player.y (+ plateforme1.y 10))        ;; On tape maintenant
               (> (+ player.x player.w) plateforme1.x)                 
               (< player.x (+ plateforme1.x plateforme1.w))) 
        (do
          (set player.y (+ plateforme1.y 10))             
          (set player.vy 0)                               
        )
      )

      ;; Sol Global
      (if (> player.y 128)
        (do
          (set player.y 128)
          (set player.vy 0)
          (set player.au-sol true) 
        )
      )

      ;; -- SAUT (Dynamique) --
      (if (and player.au-sol (btnp 4)) 
        (do 
          (set player.vy -7)
        )
      )

      ;; -- AFFICHAGE DECORS --
      (print (.. "SCORE : " score) 5 5 couleur-texte)
      (print "=======" plateforme1.x plateforme1.y couleur-texte)
    )
  )
)