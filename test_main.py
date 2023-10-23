from main import load_data, get_data_descriptive_stats
import pandas as pd
import time
import psutil

def test_loaddata():
    #load iris dataset
    path = 'full_data.csv'
    iris_df = load_data(path)
    assert isinstance(iris_df, pd.DataFrame)
    assert not iris_df.empty

def test_descriptive_stats():
    path = 'full_data.csv'
    gun_df = load_data(path) 
    statistics = get_data_descriptive_stats(gun_df,'age')
    #print(statistics['Mean'])
    assert statistics['Mean'] == 43.85760071442746

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