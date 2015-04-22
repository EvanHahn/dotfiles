interactive scp
===============

I always get tripped up on the syntax of scp and have to look it up, so I wrote `iscp`, an interactive scp.

It's a simple shell script that'll ask you a few questions and send your files on their way. It doesn't aim to expose 100% of scp but if you want to copy files/folders to/from a server, iscp is for you.

```
$ iscp

~~** hey it's me, interactive scp **~~

Are you copying FROM or TO a remote server? to
What's the ADDRESS of the remote server? myserver.biz
What's your USERNAME on that remote server? evanhahn
Where are you copying TO on the remote server? (Type "ssh" to ssh in and check.) Desktop/
What is the LOCAL PATH of this file? README.md

Alright, I'm gonna run this command unless you say I shouldn't:

scp README.md evanhahn@myserver.biz:Desktop/

Press return to continue. Anything else will abort.

# ...the file copies...

~~** iscp will miss u **~~
```

It detects whether you're copying a folder (filling in the `-r` flag for you) and is pretty cool.

This should be considered *not super stable* so please don't get super angry if it fails on you.
