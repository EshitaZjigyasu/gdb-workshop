#include <iostream>
using namespace std;

int main() {
    int *p = nullptr;
    *p = 42;  // SIGSEGV: Attempting to dereference null pointer
    cout << "Value: " << *p << endl;
    return 0;
}
