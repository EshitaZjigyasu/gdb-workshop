#include <iostream>
#include <vector>
#include <string>
#include <algorithm>
#include <cstdlib>
using namespace std;

struct Student {
    string name;
    vector<int> marks;
};

double average_top_k(const vector<int>& a, int k) {
    vector<int> b = a;
    sort(b.begin(), b.end(), greater<int>());
    long long sum = 0;
    for (int i = 0; i <= k; i++) {  // BUG1: <= causes OOB
        sum += b[i];
    }
    return (double)sum / k;  // BUG2: division by zero when k == 0
}

void print_student_info(const vector<Student>& students, int idx) {
    cout << "Student: " << students[idx].name << "\n";  // BUG3: unchecked idx
    cout << "Marks: ";
    for (size_t i = 0; i <= students[idx].marks.size(); i++) {  // BUG4: <= causes OOB
        cout << students[idx].marks[i] << " ";
    }
    cout << "\n";
}

int calculate_total(const vector<int>& marks) {
    int total = 0;
    for (int i = 0; i <= marks.size(); i++) {  // BUG5: <= causes OOB
        total += marks[i];
    }
    return total;
}

int main(int argc, char** argv) {
    vector<Student> s = {
        {"Asha", {10, 20, 30}},
        {"Ravi", {100}},
        {"Meera", {40, 50}}
    };
    
    int idx = (argc >= 2) ? atoi(argv[1]) : 0;
    int k = (argc >= 3) ? atoi(argv[2]) : 3;
    
    print_student_info(s, idx);  // BUG3: may access out of bounds
    
    cout << "Avg top-k = " << average_top_k(s[idx].marks, k) << "\n";
    
    // Additional bug: accessing non-existent student
    if (argc >= 4) {
        int idx2 = atoi(argv[3]);
        cout << "Total marks: " << calculate_total(s[idx2].marks) << "\n";  // BUG6: unchecked idx2
    }
    
    return 0;
}
