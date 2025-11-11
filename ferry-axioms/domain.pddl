(define (domain ferry_ext)
    (:requirements :derived-predicates :existential-preconditions :negative-preconditions :strips :typing)
    (:types
        car location - object
    )
    (:predicates (at ?c - car ?l - location)  (at-ferry ?l - location)  (at__ug ?c - car ?l - location)  (at_g ?c - car ?l - location)  (board_pp ?car - car ?loc - location)  (debark_pp ?car - car ?loc - location)  (empty-ferry) (on ?c - car)  (sail_pp ?from - location ?to - location))
    (:derived (at__ug ?c ?l) (and (not (at ?c ?l)) (at_g ?c ?l)))
     (:derived (board_pp ?car ?loc) (exists (?location1 - location) (and (at ?car ?loc) (at-ferry ?loc) (empty-ferry) (at__ug ?car ?location1))))
     (:derived (debark_pp ?car ?loc) (and (at-ferry ?loc) (on ?car) (at__ug ?car ?loc)))
     (:derived (sail_pp ?from ?to) (exists (?car0 - car ?location2 - location) (and (at ?car0 ?to) (at-ferry ?from) (empty-ferry) (at__ug ?car0 ?location2))))
     (:derived (sail_pp ?from ?to) (exists (?car0 - car) (and (at ?car0 ?to) (at-ferry ?from) (empty-ferry) (at__ug ?car0 ?from))))
     (:derived (sail_pp ?from ?to) (exists (?car0 - car) (and (at-ferry ?from) (on ?car0) (at__ug ?car0 ?to))))
    (:action board
        :parameters (?car - car ?loc - location)
        :precondition (and (at ?car ?loc) (at-ferry ?loc) (empty-ferry) (board_pp ?car ?loc))
        :effect (and (on ?car) (not (at ?car ?loc)) (not (empty-ferry)))
    )
     (:action debark
        :parameters (?car - car ?loc - location)
        :precondition (and (on ?car) (at-ferry ?loc) (debark_pp ?car ?loc))
        :effect (and (at ?car ?loc) (empty-ferry) (not (on ?car)))
    )
     (:action sail
        :parameters (?from - location ?to - location)
        :precondition (and (at-ferry ?from) (not (at-ferry ?to)) (sail_pp ?from ?to))
        :effect (and (at-ferry ?to) (not (at-ferry ?from)))
    )
)