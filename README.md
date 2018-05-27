# Gabrielize

![Gabrielize](./images/header.png)

## Introduction
_Gabrielize_ is an aggregate of scripts to initialize personal devices.

## Requirements
```bash
pip install -r lists/requirements
```
or install `pyfliget`, `gitpython`, `six` and `requests`.

## Download
```bash
git clone https://github.com/derogab/gabrielize.git
```

## Usage
### in a python script
```python
import gabrielize

gabrielize.command(params);
# for example: gabrielize.repo('/folder/to/save/repositories')
```
### in CLI
```bash
# tips and tricks :)
# it may be necessary to make the script executable with the following command
# chmod +x ./run.py
 

./run.py COMMAND PARAMS
# for example: ./run.py repo /folder/to/save/repositories
```

## Commands
### `Repo`
Download (or update) a list of repositories to a specific folder.
```bash
./run.py repo /folder/to/save/repositories
```
```python
gabrielize.repo('/folder/to/save/repositories')
```