(define (problem problema-base)
(:domain robot-limpieza)

;; ==== OBJECTS ====
(:objects 
 r1 - robot
 
 ;; locations
 aula1 - aula
 aula2 - aula
 aula3 - aula
 residuos - ubicacion
 
 ;; bags
 b1 b2 b3 b4 - bolsa
)

;; ==== INITIAL STATE ====
(:init 
 ;; El robot empieza en aula1
 (en r1 aula1)
 (robot-libre r1)
 
 ;; conectividad entre locations
 (adyacente aula1 aula2)
 (adyacente aula2 aula1)
 (adyacente aula2 aula3)
 (adyacente aula3 aula2)
 (adyacente aula3 residuos)
 (adyacente residuos aula3)
 
 ;; estado inicial de las aulas (todas sucias)
 (sucia aula1)
 (sucia aula2)
 (sucia aula3)
 
 ;; Initial position all bags
 (bolsa-en b1 aula1)
 (bolsa-en b3 aula2)
 (bolsa-en b4 aula2)
 (bolsa-en b2 aula3)
 )
 
 ;; === META ===
 (:goal (and
   ;; All rooms must be clean.
   (limpia aula1)
   (limpia aula2)
   (limpia aula3)
   
   ;; No debe haber bolsas en las aulas
     (bolsa-depositada b1)
  (bolsa-depositada b2)
  (bolsa-depositada b3)
  (bolsa-depositada b4)
 ))
)