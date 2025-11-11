#!/usr/bin/env python3

import os

CUR_DIR = os.path.dirname(os.path.abspath(__file__))
TESTING_DIR = f"{CUR_DIR}/testing"


for i in [0, 1, 2]:
    seeds = list(range(1, 31))
    if i == 0:
        cocktails = [4, 5, 6, 7, 8] * 6
        ingredients = [3] * 30
    elif i == 1:
        cocktails = [20, 30, 40, 50, 60] * 6
        ingredients = [4, 5, 6] * 10
    else:
        cocktails = list(range(103, 400, 10))
        ingredients = [10, 20, 30] * 10
    cocktails = sorted(cocktails)
    ingredients = sorted(ingredients)

    for j in range(30):
        problem = f"p{i}_{j+1:02d}"
        problem_file = f"{TESTING_DIR}/{problem}.pddl"
        cmd = f"python3 {CUR_DIR}/barman-generator.py {cocktails[j]} {ingredients[j]} {cocktails[j] + 1} {seeds[j]} > {problem_file}"
        os.system(cmd)
