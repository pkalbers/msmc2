# Set this variable to your static gsl libraries
# GSL = /usr/local/lib/libgsl.a /usr/local/lib/libgslcblas.a
GSL=/usr/local/lib/libgsl.a /usr/local/lib/libgslcblas.a

release : build/release/msmc2

all: debug release decode

debug : build/debug/msmc2

all : debug release

unittest: build/debug/unittest
	build/debug/unittest

build/debug/msmc2 : model/*.d powell.d brent.d maximization_step.d expectation_step.d msmc2.d logger.d
	dmd -debug ${GSL} -odbuild/test -of$@ $^

build/release/msmc2 : model/*.d powell.d brent.d maximization_step.d expectation_step.d msmc2.d logger.d
	dmd -O ${GSL} -odbuild/test -of$@ $^

build/debug/unittest : model/*.d
	dmd -unittest ${GSL} -main -odbuild/debug -ofbuild/debug/unittest $^

decode : build/decode

build/decode : model/*.d decode.d 
	dmd -O ${GSL} -odbuild -of$@ $^

decode_mod : build/decode_mod

build/decode_mod : model/*.d decode_mod.d
	dmd -O ${GSL} -odbuild -of$@ $^

clean :
	rm -rf build/*

.PHONY : clean unittest

