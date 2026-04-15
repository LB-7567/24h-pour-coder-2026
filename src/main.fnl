;; script: fennel
(var couleur-texte 2)
(var couleur-fond 0)
(var couleur-textee 12)
(var t 0)
(fn Gameover []
  (cls couleur-fond)
  (print "GAME OVER !" 87 64  couleur-texte)
(fn _G.TIC []
  (Gameover))

