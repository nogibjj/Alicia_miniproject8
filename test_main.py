from main import load_data, get_data_descriptive_stats
import pandas as pd
import time
import psutil

def test_loaddata():
    #load iris dataset
    path = 'vehicles.csv'
    iris_df = load_data(path)
    assert isinstance(iris_df, pd.DataFrame)
    assert not iris_df.empty

def test_descriptive_stats():
    path = 'vehicles.csv'
    vehicles_df = load_data(path) 
    statistics = get_data_descriptive_stats(vehicles_df,'Acceleration')
    #print(statistics['Mean'])
    assert statistics['Mean'] == 15.519704433497537

def test():
    start = time.time()
    test_loaddata()
    test_descriptive_stats()

    end = time.time()
    duration = end - start
    cpu_usage = psutil.cpu_percent()
    mem_usage = psutil.virtual_memory()

    print(f"Elapsed time: {duration:.4f} seconds")
    print(f"CPU Usage: {cpu_usage}%")
    print(f"Memory Usage: {mem_usage.percent}%")


if __name__ == "__main__":
    test()
    print("CICD Passed.")