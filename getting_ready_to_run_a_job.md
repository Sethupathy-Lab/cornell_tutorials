# Running a job on the Cornell clusters

We need to first need to reserve a machine to run our job on cbsu. Information on getting an account, logining on to CBSU, and reserving machines can be found in the [CBSU quickstart guide](https://cbsu.tc.cornell.edu/lab/userguide.aspx?a=quickstart). 

I would recommend using screen when running jobs on reserved machines, as you don't have to have many tabs open and you don't have to worry about your job being terminated if your connection to the cluster is interrupted. First, check out this short (~2min) video on [how to use screen](https://www.rackaid.com/blog/linux-screen-tutorial-and-how-to/). Screen is already installed on CBSU, so when we log onto CBSU, but before we connect to our reserved computer, type:
```
screen -S <name_of_screen_session>
```
where name_of_screen_session would be descriptive of what you are running (eg miRhub). To detach from a screen, you type ctr+a+d. You can see which screen sessions you are running by typing: `screen -ls` and you can reconnect to a screen session by typing: `screen -r <name_of_screen_session>`.

Once you have a screen session started, you can connect to your reserved machine and make a Cornell ID named directory in the work directory:

```
$ cd /workdir/
$ mkdir <Cornell user ID here>
```

Whenever we are running jobs, we will have to transfer our files to that location and run everything from there.
