# Eye Protector

A bash script to protect the eyes during long hours of work. This creates a specific period of screen darkness with an information message to divert the eyes.

## Usage 


Use the following options:
```
  -h, --help                  Show help options
  -b, --background		    Start application in background and across sessions
  -c, --close                 Close/kill the application
  -v, --version               Version of the package.
```   

**`-b`** option starts the script in the persistent mode across all shells. **`-c`** options is use to terminate the script.

## Installation


1. Download the tar file from [here](https://github.com/sachinkumarsingh092/eye-protector/archive/v1.0.tar.gz).

2. In your terminal, change directory to the `Downloads` folder.

3. Now write the following command:
```
tar xf eye-protector-1.0.tar.gz
```
4. `cd` to **eye-protector-1.0.tar.gz**

5. Change the perissions of the script:
```
chmod u+x eye-protector.sh
```

6. Run the script using `./eye-protector --options`
