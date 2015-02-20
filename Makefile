build:
	sudo ./build.sh -v

clean:
	sudo rm -f work/build.make_*

rebuild: clean build
