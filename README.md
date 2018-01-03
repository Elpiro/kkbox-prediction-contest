Project made in collaboration with Ben Chen https://github.com/benbenbang

# Python Script

### Files Hierarchy

- kkbox.py ( as `main` )
- README.md
- tools
  - dataIO.py
  - helperOutput.py
  - wrangling.py
  - requirement.txt
  - README.md

### Instruction

- Python Version: `python3`
- Run `python3` , `jupyter notebook` or set default directory under `py_script` folder


- For easier to use `main`:

  - for **csv** files:  place them in `../data` 
    1. Concated csv files
       - kkbox.csv
       - kkbox_test.csv
    2. Raw csv files
       - train.csv
       - test.csv
       - songs.csv
       - members.csv
       - song_extra_info.csv
  - for **pickle** files: place them in `..data/pickle`
    - train_sparse.pickle
    - test_sparse.pickle
    - target.pickle
  - for **xgboost model weights**: place them in `..data/models`
    - xgbt_**nn**.model (**nn** is number, ex. 01, 02, ...)

- Basically, we will need at least `kkbox.csv` and `kkbox_test.csv`. If missing one or more of them, use `importAndMergeCSV('train')` and `importAndMergeCSV('test')` to get `pd.DataFrame`. Don't forget to save one copy to save your time for next loading.

- Useful functions in `tools`

  - In `dataIO`:

    - `importAndMergeCSV(type_)`
    - `importAndMergeHDF5(type_)`
    - `loadPickle(path)`
    - `savePickle(data, path)`

  - In `wrangling`

    - `loadAndPreprocess(csv_path=None, to_train_mode=False, to_test_mode=False)`
    - `getFreqOfTarget(df)`

  - In `helperOutput`

    - `outputHelper(model, X_test_sparse=None, load_test_set=False)`
    - `loadModelHelper(version)`

    ​

