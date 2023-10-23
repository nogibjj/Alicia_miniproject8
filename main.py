import pandas as pd

def load_data(datapath):
    return pd.read_csv(datapath,sep=";")

def get_data_descriptive_stats(dataframe,column):
    statistics = {
        'Mean': dataframe[column].mean(),
        'Median': dataframe[column].median(),
        'StdDev': dataframe[column].std(),
        'Min': dataframe[column].min(),
        'Max': dataframe[column].max()
    }
    return pd.Series(statistics)