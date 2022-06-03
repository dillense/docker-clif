docker-clif
===========

![CLIF logo](https://raw.githubusercontent.com/dillense/docker-clif/master/clif_100.png "CLIF is a Load Injection Framework")

what to do with it?
-------------------

[CLIF is an open source performance testing software.](http://clif.ow2.org)

Practically, docker-clif is based on a Ubuntu 22.04 image, with Java OpenJDK headless JDK version 8, and CLIF-2.3.8-server CLIF distribution package.

The provided CLIF runtime is suitable for using all line commands of CLIF, including the pure Java-based simple GUI. Therefore, this image allows for:
- running a CLIF registry (for registering CLIF servers),
- running a CLIF server (for deploying load injectors and probes),
- deploying and running CLIF test plans over CLIF servers,
- getting a quick statistical overview of response times for each test run (not mentioning the complete set of detailed measurements availavle in the usual `report` folder).

Notes:
- for writing test scenarios, use [CLIF's main GUI based on Eclipse](http://forge.ow2.org/project/showfiles.php?group_id=57 "Download"), unless you are an absolute XML freak.
- for automatic performance test runs and reports, think about using [CLIF's plug-in](https://wiki.jenkins-ci.org/display/JENKINS/CLIF+Performance+Testing+Plugin) for [Jenkins](https://jenkins.io/).

usage
-----

- `$ docker pull dillense/clif`

    Import the docker-clif image to your local repository.

- `$ docker images`

    Check the docker-clif image is in your local repository.

- `$ docker run -ti clif`

    Launch a docker-clif container with an interactive shell, logged as user clif and with current directory set to /home/clif. All CLIF commands are available right away.

- `$ docker run -ti --network host clif`

    Same as above, except current host address is used instead of Docker's default bridge NAT'ed address. Option "--network host" is mandatory as soon as you perform distributed testing with CLIF servers (docker-clif instances) spread over different hosts, because CLIF's networking internals don't support NAT.

- `$ docker run -ti --network host clif -c "clifcmd config somehost && clifcmd server clif1"`

    Same as above, but runs a command (actually two CLIF commands) instead of running an interactive shell.

Refer to chapter 8.2 of [CLIF's user manual](http://clif.ow2.org/doc/user_manual/manual/UserManual.pdf "PDF") for a complete reference of clif commands. Test plans and scenarios examples may be found [here](http://clif.ow2.org/doc/clif-examples.zip "Download CLIF examples"). Some CLIF command examples are given below.

example
-------
```
$ docker run -ti
clif@845774c7c9da:~$ wget https://clif.ow2.io/clif-legacy/download/clif-examples.zip
[...]
clif@845774c7c9da:~$ unzip clif-examples.zip
[...]
clif@845774c7c9da:~$ cd examples
clif@845774c7c9da:~/examples$ clifcmd launch dummy dummy.ctp dummy1
Trying to connect to an existing CLIF Registry...
Failed.
Creating a CLIF Registry...
Fractal registry is ready.
Deploying from dummy.ctp test plan definition...
Test plan dummy is deployed.
Initializing
Initialized
Starting dummy test plan...
Started
Waiting for test termination...
Collecting data from test plan dummy...
Collection done
test run dummy complete
clif@845774c7c9da:~/examples$ clifcmd quickstats
action type	calls	min	max	mean	median	std dev	throughput	errors
dummy action 	   536	     1	   998	504.703	   503	288.320	17.974	    63
GLOBAL LOAD	   536	     1	   998	504.703	   503	288.320	17.974	    63
Quick statistics report done
clif@845774c7c9da:~/examples$ more report/dummy1*/0/action
# date, session id, action type, iteration, success, duration, comment, result
261,0,dummy action,0,true,378,successful dummy request,378
261,17,dummy action,0,true,638,successful dummy request,638
261,19,dummy action,0,true,215,successful dummy request,215
[...]
```
