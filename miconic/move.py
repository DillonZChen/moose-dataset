#!/usr/bin/env python3

import os

for i in range(1, 31):
    os.system(f"mv testing/hard/p{i:02d}.pddl testing/p2_{i:02d}.pddl")