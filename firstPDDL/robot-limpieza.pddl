(define (domain robot-limpieza)

    (:requirements
        :strips
        :typing
    )

    (:types
    ubicacion - object
    aula - ubicacion
    robot - object
    bolsa - object
    )

    (:predicates
    ;; ubicación del robot
    (en ?r - robot ?u - ubicacion)
   
    ;; conectividad entre ubicaciones
    (adyacente ?u1 - ubicacion ?u2 - ubicacion)
    
    ;; Estado de las aulas
    (sucia ?a - aula)
    (limpia ?a -aula)
    
    ;; Estado de las bolsa
    (bolsa-en ?b - bolsa ?u - ubicacion)
    (robot-cargando ?r - robot ?b - bolsa)
    (bolsa-depositada ?b - bolsa)
    
    ;; Control de capacidad del robot
    (robot-libre ?r - robot)
)
;; ===== ACCIONES =====

    ;; Acción 1: MOVERSE entre ubicaciones adyacentes
    (:action mover 
      :parameters (?r - robot ?desde - ubicacion ?hacia - ubicacion)
      :precondition (and 
      (en ?r ?desde)
      (adyacente ?desde ?hacia)
      )
      :effect (and 
      (not (en ?r ?desde))
      (en ?r ?hacia)
      )
    )
     
    ;; Acción 2: RECOGER una bolsa
    (:action recoger-bolsa
      :parameters (?r -robot ?b - bolsa ?u - ubicacion)
      :precondition (and
      (en ?r ?u)
      (bolsa-en ?b ?u)
      (robot-libre ?r) ;Solo puede llevar una bolsa
      )
      :effect (and 
      (not (bolsa-en ?b ?u))
      (not (robot-libre ?r))
      (robot-cargando ?r ?b)
      )
    )
    
    ;; Acción 3: DEPOSITAR bolsa en residuos
    (:action depositar-bolsa
      :parameters (?r - robot ?b - bolsa)
      :precondition (and 
        (en ?r residuos)
        (robot-cargando ?r ?b)
      )
      :effect (and
      (not (robot-cargando ?r ?b))
      (robot-libre ?r)
      (bolsa-depositada ?b)
      )
     )
     
    ;; Acción 4: LIMPIAR un aula
    (:action limpiar-aula
      :parameters (?r - robot ?a - aula)
      :precondition (and 
       (en ?r ?a)
       (sucia ?a)
       )
      :effect (and
      (not (sucia ?a))
      (limpia ?a)
      )
    )
  )