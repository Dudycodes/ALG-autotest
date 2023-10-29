#ALG-autotest
## Anotation
Short <i>Bash</i> script to automate testing of HW from CTU FEE ALG course.

## Usage

```
  ./test_script [-h] -m <relative path to main> -t <relative path to test folder>
```

## Functionality
The script checks for existence of file/directory under given relative path.
Then proceeds to get a list of pub*.in files which it sequentially passes to stdin of given main program (e.g. one file to one instance).
Output is stored in pub*_my.out files in the same folder. (Please ensure you have write privileges for the test folder.)
If the outputs match, a note of it is printed. Otherwise output of diff is printed.
After all the tests a statistic is printed out.

## Change log
29.10.2023 - initial release

