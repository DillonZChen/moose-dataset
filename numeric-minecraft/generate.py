#!/usr/bin/env python3

import os
import random
from itertools import product

import numpy as np
import pddl
import plotly.express as px
from pddl.core import Problem
from pddl.logic.base import And
from pddl.logic.functions import EqualTo, NumericFunction, NumericValue
from pddl.logic.terms import Constant
from tqdm import tqdm

CUR_DIR = os.path.dirname(os.path.abspath(__file__))

DOMAIN = pddl.parse_domain(os.path.normpath(f"{CUR_DIR}/domain.pddl"))
TRAINING_DIR = os.path.normpath(f"{CUR_DIR}/training")
TESTING_DIR = os.path.normpath(f"{CUR_DIR}/testing")
os.makedirs(TRAINING_DIR, exist_ok=True)
os.makedirs(TESTING_DIR, exist_ok=True)

random.seed(0)
np.random.seed(0)

PREDICATES = {p.name: p for p in DOMAIN.predicates}


def get_as_problem(number: int, training: bool):
    if not training:
        divider = 5
    else:
        divider = 11

    if training:
        cells = (number // divider) + 2
        cells *= cells
        pogos = number % 10
        if pogos == 0:
            pogos = 10
    else:
        difficulty = (number - 1) // 30
        instance = (number - 1) % 30 + 1
        print(number, difficulty, instance)
        if difficulty == 0:
            cells = 5 + instance * 3
            pogos = 3 + instance
        elif difficulty == 1:
            cells = 125 + instance * 5
            pogos = 75 + instance * 2
        else:
            cells = 300 + instance * 50
            pogos = 150 + instance * 5

    pogos = min(pogos, cells // 2)

    # 2 trees per pogo, with a minimum of 3 trees for problem to be solvable
    n_trees = min(max(3, pogos * 2), cells)  
    if n_trees == cells:
        cells += 3
    objects = {}
    for i in range(cells):
        objects[i] = Constant(f"cell{i}", "cell")

    # print()
    # print("*" * 80)
    # print(f"{number=}", f"{training=}", f"{pogos=}", f"{cells=}")
    init = []
    init.append(PREDICATES["position"](objects[0]))
    for func in [
        "count_log_in_inventory",
        "count_planks_in_inventory",
        "count_stick_in_inventory",
        "count_sack_polyisoprene_pellets_in_inventory",
        "count_tree_tap_in_inventory",
        # "pogo_sticks_to_make",
    ]:
        init.append(EqualTo(NumericFunction(func), NumericValue(0)))
    tree_locations = set(random.sample(list(range(cells)), n_trees))
    for i in range(cells):
        if i in tree_locations:
            init.append(PREDICATES["tree_cell"](objects[i]))
        else:
            init.append(PREDICATES["air_cell"](objects[i]))

    goal = []
    init.append(EqualTo(NumericFunction("pogo_sticks_to_make"), NumericValue(pogos)))
    goal.append(EqualTo(NumericFunction("pogo_sticks_to_make"), NumericValue(0)))

    # print("init")
    # for k in init:
    #     print(k)
    # print("\ngoals")
    # for k in goals:
    #     print(k)
    # # breakpoint()
    problem = Problem(
        name=f"prob{number}",
        domain=DOMAIN,
        objects=objects.values(),
        init=init,
        goal=And(*goal),
    )

    return problem, pogos, cells


def random_partition(n, parts):
    partitions = [0 for _ in range(parts)]
    for _ in range(n):
        partition_index = random.randint(0, parts - 1)
        partitions[partition_index] += 1
    assert sum(partitions) == n
    return partitions


if __name__ == "__main__":
    df = {"pogos": [], "cells": [], "prob": []}
    for j, i in tqdm(list(product([0, 1, 2], range(1, 31)))):
        problem, pogos, cells = get_as_problem(j * 30 + i, training=False)
        prob = f"{j}_{i:02d}"
        df["pogos"].append(pogos)
        df["cells"].append(cells)
        df["prob"].append(prob)
        with open(f"{TESTING_DIR}/p{prob}.pddl", "w") as f:
            f.write(str(problem))

    fig = px.scatter(df, x="pogos", y="cells", hover_data=["prob", "pogos", "cells"])
    fig.show()
