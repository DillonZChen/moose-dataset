(define (domain ferry_ext)
    (:requirements :derived-predicates :disjunctive-preconditions :existential-preconditions :negative-preconditions :strips :typing)
    (:types
        car location - object
    )
    (:predicates (at ?c - car ?l - location)  (at-ferry ?l - location)  (at__ug ?c - car ?l - location)  (at_g ?c - car ?l - location)  (board_pp ?car - car ?loc - location)  (debark_pp ?car - car ?loc - location)  (empty-ferry) (on ?c - car)  (sail_pp ?from - location ?to - location))
    (:action board
        :parameters (?car - car ?loc - location)
        :precondition (and (at ?car ?loc) (at-ferry ?loc) (empty-ferry) (exists (?location1 - location) (and (at ?car ?loc) (at-ferry ?loc) (empty-ferry) (not (at ?car ?location1)) (at_g ?car ?location1))))
        :effect (and (on ?car) (not (at ?car ?loc)) (not (empty-ferry)))
    )
     (:action debark
        :parameters (?car - car ?loc - location)
        :precondition (and (on ?car) (at-ferry ?loc) (not (at ?car ?loc)) (at_g ?car ?loc))
        :effect (and (at ?car ?loc) (empty-ferry) (not (on ?car)))
    )
     (:action sail
        :parameters (?from - location ?to - location)
        :precondition (and (at-ferry ?from) (not (at-ferry ?to)) (or (exists (?location2 - location ?car0 - car) (and (at ?car0 ?to) (at-ferry ?from) (empty-ferry) (not (at ?car0 ?location2)) (at_g ?car0 ?location2))) (exists (?car0 - car) (and (at ?car0 ?to) (at-ferry ?from) (empty-ferry) (not (at ?car0 ?from)) (at_g ?car0 ?from))) (exists (?car0 - car) (and (at-ferry ?from) (on ?car0) (not (at ?car0 ?to)) (at_g ?car0 ?to)))))
        :effect (and (at-ferry ?to) (not (at-ferry ?from)))
    )
)
