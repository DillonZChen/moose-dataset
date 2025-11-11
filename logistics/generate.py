#!/usr/bin/env python3

import os

_CUR_DIR = os.path.dirname(os.path.abspath(__file__))
BIN = f"{_CUR_DIR}/logistics"


def main():
    untyped_problem = f"tmp.pddl"

    for i in range(30):
        typed_problem = f"{_CUR_DIR}/training/p{i+1:02d}.pddl"
        os.system(f"{BIN} -a 3 -c 3 -s 5 -p 5 -t 3 -r {i} > {untyped_problem}")
        write_problem(untyped_problem, typed_problem)
        if os.path.exists(untyped_problem):
            os.remove(untyped_problem)

    limer = [
        (5, 0.5, 0.3, 0.3, 2),
        (20, 1, 0.45, 0.45, 8),
        (50, 2, 0.6, 0.6, 15),
    ]
    for diff in [0, 1, 2]:
        lo = limer[diff][0]
        inc = limer[diff][1]
        c_a = limer[diff][2]
        c_c = limer[diff][3]
        c_s = limer[diff][4]
        for i in range(30):
            typed_problem = f"{_CUR_DIR}/testing/p{diff}_{i+1:02d}.pddl"

            packages = int(lo + i * inc)
            airplanes = int(packages * c_a)
            cities = int(packages * c_c)
            size = c_s
            trucks = cities

            os.system(f"{BIN} -a {airplanes} -c {cities} -s {size} -p {packages} -t {trucks} -r {i} > {untyped_problem}")
            write_problem(untyped_problem, typed_problem)
            if os.path.exists(untyped_problem):
                os.remove(untyped_problem)


def write_problem(from_file, to_file):
    with open(from_file, "r") as f:
        content = f.read()

    new_content = ""
    for line in content.split("\n"):
        if line.startswith("(:objects"):
            airplane = " ".join(line.split()[1:])
            assert airplane.startswith("a")
            new_content += f"(:objects {airplane} - airplane"
        elif line.strip().startswith("c"):
            new_content += f"{line}- city"
        elif line.strip().startswith("p"):
            new_content += f"{line}- package"
        elif line.strip().startswith("l"):
            new_content += f"{line}- location"
        elif line.strip().startswith("t"):
            new_content += f"{line}- truck"
        elif line.strip().startswith("(AIRPLANE"):
            continue
        elif line.strip().startswith("(CITY"):
            continue
        elif line.strip().startswith("(TRUCK"):
            continue
        elif line.strip().startswith("(LOCATION"):
            continue
        elif line.strip().startswith("(PACKAGE"):
            continue
        elif line.strip().startswith("(OBJ"):
            continue
        elif line.strip().startswith("(AIRPORT"):
            line = line.replace("AIRPORT", "has-airport")
            new_content += line
        else:
            new_content += line

        new_content += "\n"

    with open(to_file, "w") as f:
        f.write(new_content)


if __name__ == "__main__":
    main()
