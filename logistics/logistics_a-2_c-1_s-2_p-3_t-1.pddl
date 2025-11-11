


(define (problem logistics-c1-s2-p3-a2)
(:domain logistics)
(:objects a0 a1 - airplane
          c0 - city
          t0 - truck
          l0-0 l0-1 - location
          p0 p1 p2 - package
)
(:init
    (in-city  l0-0 c0)
    (in-city  l0-1 c0)
    (has-airport l0-0)
    (at t0 l0-1)
    (at p0 l0-0)
    (at p1 l0-0)
    (at p2 l0-1)
    (at a0 l0-0)
    (at a1 l0-0)
)
(:goal
    (and
        (at p0 l0-0)
        (at p1 l0-1)
        (at p2 l0-1)
    )
)
)



