(define (domain transport_ext)
    (:requirements :derived-predicates :existential-preconditions :typing)
    (:types
        locatable location size - object
        package vehicle - locatable
    )
    (:predicates (at ?x - locatable ?v - location)  (at__ug ?x - locatable ?v - location)  (at_g ?x - locatable ?v - location)  (capacity ?v - vehicle ?s1 - size)  (capacity-predecessor ?s1 - size ?s2 - size)  (drive_pp ?v - vehicle ?l1 - location ?l2 - location)  (drop_pp ?v - vehicle ?l - location ?p - package ?s1 - size ?s2 - size)  (in ?x - package ?v - vehicle)  (pick-up_pp ?v - vehicle ?l - location ?p - package ?s1 - size ?s2 - size)  (road ?l1 - location ?l2 - location))
    (:derived (at__ug ?x ?v) (and (not (at ?x ?v)) (at_g ?x ?v)))
     (:derived (drive_pp ?v ?l1 ?l2) (exists (?size0 - size ?size1 - size ?location2 - location ?package0 - package) (and (at ?package0 ?l2) (at ?v ?l1) (capacity ?v ?size1) (capacity-predecessor ?size0 ?size1) (at__ug ?package0 ?location2))))
     (:derived (drive_pp ?v ?l1 ?l2) (exists (?size0 - size ?size1 - size ?package0 - package) (and (at ?package0 ?l2) (at ?v ?l1) (capacity ?v ?size1) (capacity-predecessor ?size0 ?size1) (at__ug ?package0 ?l1))))
     (:derived (drive_pp ?v ?l1 ?l2) (exists (?size0 - size ?size1 - size ?package0 - package) (and (at ?v ?l1) (capacity ?v ?size0) (capacity-predecessor ?size0 ?size1) (in ?package0 ?v) (at__ug ?package0 ?l2))))
     (:derived (drop_pp ?v ?l ?p ?s1 ?s2) (and (at ?v ?l) (capacity ?v ?s1) (capacity-predecessor ?s1 ?s2) (in ?p ?v) (at__ug ?p ?l)))
     (:derived (pick-up_pp ?v ?l ?p ?s1 ?s2) (exists (?location1 - location) (and (at ?p ?l) (at ?v ?l) (capacity ?v ?s2) (capacity-predecessor ?s1 ?s2) (at__ug ?p ?location1))))
    (:action drive
        :parameters (?v - vehicle ?l1 - location ?l2 - location)
        :precondition (and (at ?v ?l1) (drive_pp ?v ?l1 ?l2))
        :effect (and (not (at ?v ?l1)) (at ?v ?l2))
    )
     (:action drop
        :parameters (?v - vehicle ?l - location ?p - package ?s1 - size ?s2 - size)
        :precondition (and (at ?v ?l) (in ?p ?v) (capacity-predecessor ?s1 ?s2) (capacity ?v ?s1) (drop_pp ?v ?l ?p ?s1 ?s2))
        :effect (and (not (in ?p ?v)) (at ?p ?l) (capacity ?v ?s2) (not (capacity ?v ?s1)))
    )
     (:action pick-up
        :parameters (?v - vehicle ?l - location ?p - package ?s1 - size ?s2 - size)
        :precondition (and (at ?v ?l) (at ?p ?l) (capacity-predecessor ?s1 ?s2) (capacity ?v ?s2) (pick-up_pp ?v ?l ?p ?s1 ?s2))
        :effect (and (not (at ?p ?l)) (in ?p ?v) (capacity ?v ?s1) (not (capacity ?v ?s2)))
    )
)