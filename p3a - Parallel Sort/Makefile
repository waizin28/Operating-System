psort: psort.c
	gcc -o psort psort.c -Wall -pthread -O
out:
	gcc -o psort psort.c -Wall -Werror
run:
	psort input.txt output.txt
test: psort
	psort ~cs537-1/tests/p3a/tests/2.in test-out/2.out
testall:
	~cs537-1/tests/p3a/test-psort.sh -c

clean:
	rm -rf ./psort
