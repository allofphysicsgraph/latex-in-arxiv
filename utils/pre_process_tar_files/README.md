# Script Description

This repository contains two bash scripts, `0.sh` and `run.sh`, designed to process and extract data from archive files within a directory structure.

## `0.sh`

### Purpose
The `0.sh` script is the main driver. It performs the following actions:

1.  **Copies `run.sh`**: Copies the `run.sh` script from the parent directory into the current directory.
2.  **Copies `.tar` files:** Copies up to the first 10 `.tar` files found in the parent directory to the current directory.
3.  **Extracts `.tar` Archives:** Extracts all `.tar` archive files that contain the string "arX" in their names from the current directory.
4.  **Executes `run.sh` in Numbered Directories:**
    *   It locates directories within the current directory that are named with four digits (e.g., "1234").
    *   For each of these directories, copies `run.sh` inside, and executes it with bash.
    * It operates on those directories from the parent directory without moving away from it during execution of `run.sh`.

### Usage
```bash
./0.sh

