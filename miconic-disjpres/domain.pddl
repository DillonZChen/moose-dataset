(define (domain miconic_ext)
    (:requirements :derived-predicates :disjunctive-preconditions :existential-preconditions :strips :typing)
    (:types
        floor passenger - object
    )
    (:predicates (above ?floor1 - floor ?floor2 - floor)  (board_pp ?f - floor ?p - passenger)  (boarded ?person - passenger)  (depart_pp ?f - floor ?p - passenger)  (destin ?person - passenger ?floor - floor)  (down_pp ?f1 - floor ?f2 - floor)  (lift-at ?floor - floor)  (origin ?person - passenger ?floor - floor)  (served ?person - passenger)  (served__ug ?person - passenger)  (served_g ?person - passenger)  (up_pp ?f1 - floor ?f2 - floor))
    (:action board
        :parameters (?f - floor ?p - passenger)
        :precondition (and (lift-at ?f) (origin ?p ?f) (or (exists (?floor1 - floor) (and (above ?f ?floor1) (destin ?p ?floor1) (lift-at ?f) (origin ?p ?f) (not (served ?p)) (served_g ?p))) (exists (?floor1 - floor) (and (above ?floor1 ?f) (destin ?p ?floor1) (lift-at ?f) (origin ?p ?f) (not (served ?p)) (served_g ?p)))))
        :effect (and (boarded ?p) (not (origin ?p ?f)))
    )
     (:action depart
        :parameters (?f - floor ?p - passenger)
        :precondition (and (lift-at ?f) (destin ?p ?f) (boarded ?p) (not (served ?p)) (served_g ?p))
        :effect (and (not (boarded ?p)) (served ?p))
    )
     (:action down
        :parameters (?f1 - floor ?f2 - floor)
        :precondition (and (lift-at ?f1) (above ?f2 ?f1) (or (exists (?passenger0 - passenger ?floor2 - floor) (and (above ?f2 ?f1) (above ?f2 ?floor2) (destin ?passenger0 ?floor2) (lift-at ?f1) (origin ?passenger0 ?f2) (not (served ?passenger0)) (served_g ?passenger0))) (exists (?passenger0 - passenger) (and (above ?f2 ?f1) (boarded ?passenger0) (destin ?passenger0 ?f2) (lift-at ?f1) (not (served ?passenger0)) (served_g ?passenger0))) (exists (?passenger0 - passenger) (and (above ?f2 ?f1) (destin ?passenger0 ?f1) (lift-at ?f1) (origin ?passenger0 ?f2) (not (served ?passenger0)) (served_g ?passenger0))) (exists (?passenger0 - passenger ?floor2 - floor) (and (above ?f2 ?f1) (above ?floor2 ?f2) (destin ?passenger0 ?floor2) (lift-at ?f1) (origin ?passenger0 ?f2) (not (served ?passenger0)) (served_g ?passenger0)))))
        :effect (and (lift-at ?f2) (not (lift-at ?f1)))
    )
     (:action up
        :parameters (?f1 - floor ?f2 - floor)
        :precondition (and (lift-at ?f1) (above ?f1 ?f2) (or (exists (?passenger0 - passenger) (and (above ?f1 ?f2) (boarded ?passenger0) (destin ?passenger0 ?f2) (lift-at ?f1) (not (served ?passenger0)) (served_g ?passenger0))) (exists (?passenger0 - passenger ?floor2 - floor) (and (above ?f1 ?f2) (above ?f2 ?floor2) (destin ?passenger0 ?floor2) (lift-at ?f1) (origin ?passenger0 ?f2) (not (served ?passenger0)) (served_g ?passenger0))) (exists (?passenger0 - passenger) (and (above ?f1 ?f2) (destin ?passenger0 ?f1) (lift-at ?f1) (origin ?passenger0 ?f2) (not (served ?passenger0)) (served_g ?passenger0))) (exists (?passenger0 - passenger ?floor2 - floor) (and (above ?f1 ?f2) (above ?floor2 ?f2) (destin ?passenger0 ?floor2) (lift-at ?f1) (origin ?passenger0 ?f2) (not (served ?passenger0)) (served_g ?passenger0)))))
        :effect (and (lift-at ?f2) (not (lift-at ?f1)))
    )
)
