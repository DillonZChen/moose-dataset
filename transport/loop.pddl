(define (problem transport-loop)
 (:domain transport)
 (:objects 
    v1 - vehicle
    p1 p2 p3 p4 p5 - package
    l1 l2 - location
    c0 c1 c2 - size
    )
 (:init (capacity v1 c1)
    (capacity v2 c1)
    (capacity v3 c2)
    (capacity-predecessor c0 c1)
    (capacity-predecessor c1 c2)
    (at p1 l1)
    (at p2 l1)
    (at p3 l1)
    (at p4 l1)
    (at p5 l1)
    (at v1 l1)
    (road l1 l2)
    )
 (:goal  (and 
    (at p1 l2)
    (at p2 l2)
    (at p3 l2)
    (at p4 l2)
    (at p5 l2)
    )))