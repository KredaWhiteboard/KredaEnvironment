# Kreda Whiteboard Environment

## Setup

After cloning the repository, to launch the environment, do the following steps:

```
cd KredaEnvironment

git submodule init
git submodule update --remote

make up
```

Available make commands:

```
make up # launches the environment
make stop # shuts down the environment and keeps the containers
make down # shuts down the environment and removes the containers
```
