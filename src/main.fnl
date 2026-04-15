;; script: fennel
(var couleur-texte 2)  ; 6 = vert. Essaie 11 (bleu clair)
(var couleur-fond 0)  ; 12 = Blanc. Essaie 0 (Noir)
(var couleur-textee 12)
(var t 0)
(fn Gameover []
  (cls couleur-fond)
  (var decalage-y (* (math.sin t) 5))
  (print "GAME OVER !" 87 (+ 64 decalage-y) couleur-texte)
  (set t (+ t 0.1))
  (if (= t 0.5)
      (print "hdefz")))
      ;;(set t (= t 0))))


(fn _G.TIC []
	(Gameover)
	;;(print " Appuyez sur ? pour afficher le menu d'accueil"  10 105 couleur-textee)
	;;appel la fonction qui appel le démarrage
	)
