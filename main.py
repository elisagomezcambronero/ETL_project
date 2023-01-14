import pandas as pd
def abrir_csv(path_fichero):
    pd.read_csv(path_fichero, index_col = 0 )
    