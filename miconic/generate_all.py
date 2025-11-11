import logging

from benchmarking_utils import execute_command


def get_next_config(
    starting_passengers: int = 1,
    max_passengers: int = 1,
    starting_floors: int = 1,
    max_floors: int = 1,
    out_folder: str = ".",
    starting_instance_id: int = 1,
    max_instance_id: int = 100,
    seed: int = 42,
):
    instance_id, steps = starting_instance_id, 0
    num_instances = float(1 + max_instance_id - starting_instance_id)
    step_passengers = float(1 + max_passengers - starting_passengers) / num_instances
    step_floors = float(1 + max_floors - starting_floors) / num_instances
    while instance_id <= max_instance_id:
        passengers = int(step_passengers * steps + starting_passengers)
        floors = int(step_floors * steps + starting_floors)
        print(f"p={passengers}; f={floors}")
        yield f"PYTHONHASHSEED=0 python miconic.py -p {passengers} -f {floors} -o {out_folder} -i {instance_id} --seed {seed}"
        # Update input values for the next instance
        instance_id += 1
        seed += 1
        steps += 1


def main():
    starting_passengers = [1, 1, 20, 100]
    max_passengers = [10, 10, 80, 1000]
    starting_floors = [4, 4, 30, 400]
    max_floors = [20, 20, 60, 1000]
    output_folders = [
        "training/easy",
        "testing/easy",
        "testing/medium",
        "testing/hard",
    ]
    max_ids = [99, 30, 30, 30]
    init_ids = [15, 1, 1, 1]  # 14 base cases
    seeds = [42, 1007, 1007, 1007]
    for experiment in range(4):
        if experiment != 3:
            continue
        # print(output_folders[experiment])
        for command in get_next_config(
            starting_passengers=starting_passengers[experiment],
            max_passengers=max_passengers[experiment],
            starting_floors=starting_floors[experiment],
            max_floors=max_floors[experiment],
            out_folder=output_folders[experiment],
            starting_instance_id=init_ids[experiment],
            max_instance_id=max_ids[experiment],
            seed=seeds[experiment],
        ):
            ret_code = execute_command(command=command, shell=True)
            logging.info(f"Executed command={command}; result={ret_code}")

    # Copy base cases
    command = "cp base_cases/* training/easy/"
    ret_code = execute_command(command=command, shell=True)
    logging.info(f"Executed command={command}; result={ret_code}")


if __name__ == "__main__":
    main()
