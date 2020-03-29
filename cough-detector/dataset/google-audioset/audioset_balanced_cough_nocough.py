import os
import pandas as pd

cough_label = "/m/01b_21"
audioset_csv_folder = 'dataset/google-audioset/csvs/'

def load_csvs_to_df(csvs_folder='./csvs/'):
    list_dfs = []
    for csv_file in os.listdir(csvs_folder):
        if '.csv' not in csv_file:
            continue
        csv_file = os.path.join(csvs_folder, csv_file)
        list_dfs.append(pd.read_csv(csv_file, delimiter='; '))
    df = pd.concat(list_dfs)
    df['positive_labels'] = df['positive_labels'].str.strip('"')
    return df

def df_to_cough_nocough_balanced(df, cough_label="/m/01b_21"):
    cough_df = df[df['positive_labels'].str.contains(cough_label)]
    nocough_df = df[~df['positive_labels'].str.contains(cough_label)]
    # shuffle
    nocough_df = nocough_df.sample(frac=1)
    # balance
    nocough_df = nocough_df[:len(cough_df)]
    #return (cough_df, nocough_df)
    cough_df.to_csv('cough_audioset.csv', sep=";", index=False)
    nocough_df.to_csv('nocough_audioset.csv', sep=";", index=False)

if __name__ == "__main__":
    df = load_csvs_to_df()
    df_to_cough_nocough_balanced(df)