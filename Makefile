COMPILER = javac
RMIC = rmic

SRC = src
BIN = classes

sources = *.java
classes = $(BIN)/$(sources:.java=.class)

all: $(classes)

$(BIN)/*.class :
	$(COMPILER) $(SRC)/*.java -d $(BIN)

rmic: all
	$(RMIC) -classpath $(BIN) ServerImpl -d $(BIN)
	$(RMIC) -classpath $(BIN) RegistryProxyImpl -d $(BIN)

tests: stop
	./run_all_tests.sh

stop:
	ps | grep StartRegistry | head -n 1 | awk '{ print $$1 }' | xargs kill

.PHONY : clean
clean :
	rm -rf $(BIN)/*.class
