TARGET = $1

build:
	nasm -felf64 ./src/${TARGET}.asm -o ./dist/${TARGET}.o && \
	ld -o ./dist/${TARGET} ./dist/${TARGET}.o

run:
	nasm -felf64 ./src/${TARGET}.asm -o ./dist/${TARGET}.o && \
	ld -o ./dist/${TARGET} ./dist/${TARGET}.o && \
	./dist/${TARGET}