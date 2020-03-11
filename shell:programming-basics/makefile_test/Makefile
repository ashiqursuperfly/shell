### Format
# target: dependencies
#--TAB-recipe1
#--TAB-recipe2
#--TAB-recipe3

### bydefault 'make' commands starts executing the first target written in makefile
### this can be overriden by : 'make my_custom_start_target_name'

### READ: GNU Makefile documentation , xv6 docs

compiler = g++

all: main.o f1.o f2.o
	$(compiler) -o out main.o f1.o f2.o
	
main.o: main.cpp
	$(compiler) -c main.cpp
        
f1.o: f1.cpp
	$(compiler) -c f1.cpp

f2.o: f2.cpp
	$(compiler) -c f2.cpp

clean:
	rm *.o
	
