;; script: fennel
(fn Gameover []
  (cls 0)
  (print "GAME OVER !" 87 64  2)
  (print "Restart ? Press down arrow" 57 94 12)
  (print "Exit ? Press upper arrow" 57 105 12)
  ;;(if (btn E)
      ;;mettre la fonction pour relancer le jeu 
    ;; )
      (if (btn A)
  	(exit)))
(fn _G.TIC []
  (Gameover))
