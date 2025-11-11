; PolyCraft advanced problem

(define (problem advanced)
	(:domain PolyCraft)
	(:objects
		cell0 cell1 cell2 cell3 cell4 cell5 cell6 cell7 cell8 cell9 cell10 cell11 cell12 cell13 cell14 cell15 - cell
	)
	(:init
		(position cell0)

		; Map
		(air_cell cell0)
		(air_cell cell1)
		(tree_cell cell2)
		(air_cell cell3)
		(air_cell cell4)
		(air_cell cell5)
		(tree_cell cell6)
		(air_cell cell7)
		(air_cell cell8)
		(air_cell cell9)
		(tree_cell cell10)
		(air_cell cell11)
		(air_cell cell12)
		(tree_cell cell13)
		(air_cell cell14)
		(air_cell cell15)

		; Items
		(= (count_log_in_inventory) 0)
		(= (count_planks_in_inventory) 0)
		(= (count_stick_in_inventory) 0)
		(= (count_sack_polyisoprene_pellets_in_inventory) 0)
		(= (count_tree_tap_in_inventory) 0)
        (= (pogo_sticks_to_make) 2)
	)
	(:goal
		(and
			(= (pogo_sticks_to_make) 0)
		)
	)
)