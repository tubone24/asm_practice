# asm_practice

An environment and practices for [tubone24](https://portfolio.tubone-project24.xyz/) to learn Assembly by imitation.

## Setup

First, build a Linux (Debian9) environment running Assembly using `docker compose`.

```
docker compose up -d
docker exec -it asm_practice bash
```

Next, we will use the make command to turn the asm file into an executable file using NASM and the GNU linker.

If you use the run command, it will run in a series of processes until execution.

```
cd /app/
make build TARGE=fizzbuzz

make run TARGET=fizzbuzz
```