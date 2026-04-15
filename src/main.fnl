;; author: Quentin
;; desc:   Template de base pour le 24h pour coder 2026
;; script: fennel


(local Player
  {:new (fn [x y sprite]
          (local self {:x x :y y :sprite sprite :vx 0 :vy 0 :speed 1.5})
          (setmetatable self {:__index Player})
          self)
			:update (fn [self]
  			(if (btn 0)
    		(tset self :vx (* -1 (get self :speed)))
    		(if (btn 1)
      	(tset self :vx (get self :speed))
      	(tset self :vx 0)))
  			(if (btn 2)
    		(tset self :vy (* -1 (get self :speed)))
    		(if (btn 3)
      	(tset self :vy (get self :speed))
      	(tset self :vy 0)))
  			(tset self :x (+ (get self :x) (get self :vx)))
  			(tset self :y (+ (get self :y) (get self :vy))))
     
   :draw (fn [self camx camy]
           (spr self.sprite (- self.x camx) (- self.y camy)))})



(var couleur-texte 6)  ; 6 = vert. Essaie 11 (bleu clair)
(var couleur-fond 0)  ; 12 = Blanc. Essaie 0 (Noir)

;; Variable pour l'animation
(var t 0)
;; (player (Player.new 40 40 1))
;; (local camx 0)
;; (local camy 0)
;; Boucle principale exécutée à 60 FPS
(fn _G.TIC []
  ;; 1. Nettoie l'écran

  (cls couleur-fond)
 
  ;;(set camx (- player.x 120))
  ;;(set camy (- player.y 68)) 
  ;; 2. Calcule un petit mouvement de vague
  (var decalage-y (* (math.sin t) 5))
  
  ;; 3. Affiche le texte au centre avec l'effet de vague
  (print "PLACEHOLDER" 90 (+ 64 decalage-y) couleur-texte)
  ;;(player :draw camx camy)
  (spr 5 100 100)
  (spr 6 110 100)
  (spr 7 120 100)
		(map 10 0 36 20 0 0)
  
  ;; 4. Fait avancer le temps
  (set t (+ t 0.1)))
