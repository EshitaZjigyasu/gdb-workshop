CXX = g++
CXXFLAGS = -g -Wall -Wextra -std=c++17

.PHONY: all clean demo1 demo2 assignment

all: demo1 demo2 assignment

demo1: demo1_buggy_sum.cpp
	$(CXX) $(CXXFLAGS) -o demo1 demo1_buggy_sum.cpp

demo2: demo2_segfault.cpp
	$(CXX) $(CXXFLAGS) -o demo2 demo2_segfault.cpp

assignment: assignment.cpp
	$(CXX) $(CXXFLAGS) -o assignment assignment.cpp

clean:
	rm -f demo1 demo2 assignment core core.* *.dSYM
