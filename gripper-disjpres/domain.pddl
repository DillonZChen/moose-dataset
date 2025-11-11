(define (domain gripper-strips_ext)
    (:requirements :derived-predicates :disjunctive-preconditions :existential-preconditions)
    (:predicates (at ?b ?r)  (at-robby ?r)  (at__ug ?b ?r)  (at_g ?b ?r)  (ball ?b)  (carry ?o ?g)  (drop_pp ?obj ?room ?gripper)  (free ?g)  (gripper ?g)  (move_pp ?from ?to)  (pick_pp ?obj ?room ?gripper)  (room ?r))
    (:action drop
        :parameters (?obj ?room ?gripper)
        :precondition (and (ball ?obj) (room ?room) (gripper ?gripper) (carry ?obj ?gripper) (at-robby ?room) (not (at ?obj ?room)) (at_g ?obj ?room))
        :effect (and (at ?obj ?room) (free ?gripper) (not (carry ?obj ?gripper)))
    )
     (:action move
        :parameters (?from ?to)
        :precondition (and (room ?from) (room ?to) (at-robby ?from) (or (exists (?any_obj2 ?any_obj3) (and (at ?any_obj2 ?to) (at-robby ?from) (ball ?any_obj2) (free ?any_obj3) (gripper ?any_obj3) (room ?from) (room ?to) (not (at ?any_obj2 ?from)) (at_g ?any_obj2 ?from))) (exists (?any_obj2 ?any_obj3) (and (at-robby ?from) (ball ?any_obj2) (carry ?any_obj2 ?any_obj3) (gripper ?any_obj3) (room ?from) (room ?to) (not (at ?any_obj2 ?to)) (at_g ?any_obj2 ?to)))))
        :effect (and (at-robby ?to) (not (at-robby ?from)))
    )
     (:action pick
        :parameters (?obj ?room ?gripper)
        :precondition (and (ball ?obj) (room ?room) (gripper ?gripper) (at ?obj ?room) (at-robby ?room) (free ?gripper) (exists (?any_obj3) (and (at ?obj ?room) (at-robby ?room) (ball ?obj) (free ?gripper) (gripper ?gripper) (room ?room) (room ?any_obj3) (not (at ?obj ?any_obj3)) (at_g ?obj ?any_obj3))))
        :effect (and (carry ?obj ?gripper) (not (at ?obj ?room)) (not (free ?gripper)))
    )
)
