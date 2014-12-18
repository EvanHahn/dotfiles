el rando
========

command line tool to generate random strings, numbers, letters, etc.

numbers:

```sh
# generate a 5-digit random integer
./el-rando.py number        # 82230

# generate a random integer less than 210
./el-rando.py number 210    # 35

# generate a random integer between 20 and 30
./el-rando.py number 20 30  # 28
```

strings (this is the default):

```sh
# generate a 40-character random string
./el-rando.py string     # _dV#]JDUH(B2[`:>JZN&c<],i]Ou`KJ^/,%r,ifA
./el-rando.py            # 0l!@BO0w)a1RMXmcs_U#D%*hWk_h?U$/BZjTmJMA

# generate at 10-character random string
./el-rando.py string 10  # 3=$=eZ,/|a
```

letters:

```sh
# generate a 40-character random string of letters
./el-rando.py letters     # jegyswrkvkijbrggxhgromtxwujysemkvgiieuuf

# generate a 10-character random string of letters
./el-rando.py letters 10  # ohoxxaiuno
```

booleans:

```sh
# generate "yes" or "no"
./el-rando.py bool  # yes
```
