FROM debian:11

RUN apt-get update
RUN apt-get install -y binutils nasm gdb gcc make auditd vim