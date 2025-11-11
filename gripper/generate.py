#!/usr/bin/env python3

import os


TRAIN = [3, 4, 5]
TEST0 = []
TEST1 = []
TEST2 = []
for i in range(30):
    TEST0.append(11+i)
    TEST1.append(130+i*30)
    TEST2.append(5*(1000+i*300))
TEST0 = sorted(TEST0)
TEST1 = sorted(TEST1)
TEST2 = sorted(TEST2)

CUR_DIR = os.path.dirname(os.path.abspath(__file__))
os.makedirs(f"{CUR_DIR}/training", exist_ok=True)
os.makedirs(f"{CUR_DIR}/testing", exist_ok=True)

for i, g in enumerate(TRAIN):
    os.system(f"{CUR_DIR}/gripper -n {g} > {CUR_DIR}/training/p{i+1:02d}.pddl")

for i, g in enumerate(TEST0):
    os.system(f"{CUR_DIR}/gripper -n {g} > {CUR_DIR}/testing/p0_{i+1:02d}.pddl")
for i, g in enumerate(TEST1):
    os.system(f"{CUR_DIR}/gripper -n {g} > {CUR_DIR}/testing/p1_{i+1:02d}.pddl")
for i, g in enumerate(TEST2):
    os.system(f"{CUR_DIR}/gripper -n {g} > {CUR_DIR}/testing/p2_{i+1:02d}.pddl")
