#include <iostream>
#include <vector>
#include <cstdlib>
using namespace std;

int buggy_sum(const vector<int>& v, int k) {
    int s = 0;
    for (int i = 0; i <= k; i++) {  // BUG: <= causes OOB
        s += v[i];                   // Out-of-bounds when k >= v.size()
    }
    return s;
}

int main(int argc, char** argv) {
    vector<int> v = {10, 20, 30};
    int k = (argc > 1) ? atoi(argv[1]) : 5;
    cout << "sum=" << buggy_sum(v, k) << "\n";
    return 0;
}
