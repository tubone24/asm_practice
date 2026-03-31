FROM debian:stretch-20220622

RUN apt-get update
RUN apt-get install -y binutils nasm gdb gcc make auditd vim