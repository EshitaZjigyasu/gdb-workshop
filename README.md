# GDB Debugging Workshop

A hands-on workshop to learn GDB (GNU Debugger) through practical examples. This workshop covers basic debugging techniques, core dump analysis, and finding multiple bugs in real code.

## Prerequisites

- A terminal/command line interface
- A C++ compiler (g++ or clang++)
- GDB debugger

## Installation

### macOS

#### Option 1: Using Homebrew (Recommended)

```bash
brew install gdb
```

After installation, you may need to code-sign GDB to use it on macOS. Run:

```bash
./install-mac.sh
```

#### Option 2: Using MacPorts

```bash
sudo port install gdb
```

### Linux (Ubuntu/Debian)

```bash
sudo apt-get update && sudo apt-get install -y gdb g++ build-essential
```

### Linux (Fedora/RHEL/CentOS)

```bash
sudo dnf install -y gdb gcc-c++ make
```

### Linux (Arch Linux)

```bash
sudo pacman -S gdb gcc make
```

### Quick Install Scripts

We provide automated installation scripts:

**macOS:**
```bash
./install-mac.sh
```

**Linux:**
```bash
./install-linux.sh
```

## Workshop Structure

### Demo 1: Basic GDB Operations (`demo1_buggy_sum.cpp`)

Learn fundamental GDB commands:
- Setting breakpoints
- Stepping through code
- Inspecting variables
- Examining the call stack
- Finding off-by-one errors

**Bug:** Off-by-one error in loop condition (`<=` instead of `<`)

**Compile:**
```bash
make demo1
```

**Run with GDB:**
```bash
gdb ./demo1
```

### Demo 2: Core Dump Analysis (`demo2_segfault.cpp`)

Learn to debug crashes:
- Analyzing segmentation faults
- Examining core dumps
- Understanding null pointer dereferences
- Using `backtrace` and `frame` commands

**Bug:** Null pointer dereference causing SIGSEGV

**Compile:**
```bash
make demo2
```

**Run with GDB:**
```bash
gdb ./demo2
```

**Generate core dump:**
```bash
ulimit -c unlimited
./demo2
gdb ./demo2 core
```

### Demo 3: Assignment - Find Multiple Bugs (`assignment.cpp`)

Put your skills to the test! Find and fix multiple bugs:
- Off-by-one errors
- Division by zero
- Array/vector bounds checking
- Logic errors

**Bugs:** Multiple issues including:
- Off-by-one in loop
- Division by zero
- Unchecked array index
- Potential memory issues

**Compile:**
```bash
make assignment
```

**Run with GDB:**
```bash
gdb ./assignment
```

## Quick Start

1. **Clone this repository:**
   ```bash
   git clone <repository-url>
   cd gdb-workshop
   ```

2. **Install GDB** (if not already installed):
   ```bash
   # macOS
   ./install-mac.sh
   
   # Linux
   ./install-linux.sh
   ```

3. **Compile all programs:**
   ```bash
   make all
   ```

4. **Start with Demo 1:**
   ```bash
   gdb ./demo1
   ```

## GDB Cheat Sheet

### Starting GDB
```bash
gdb ./program              # Start GDB with program
gdb ./program core         # Analyze core dump
gdb ./program <pid>        # Attach to running process
```

### Basic Commands
```
run [args]                 # Run the program
start                      # Start and stop at main
continue (c)              # Continue execution
next (n)                  # Execute next line (step over)
step (s)                  # Execute next line (step into)
finish                    # Execute until current function returns
quit (q)                  # Exit GDB
```

### Breakpoints
```
break (b) <location>      # Set breakpoint at location
break main                # Break at main function
break file.cpp:42         # Break at line 42 in file.cpp
break function_name       # Break at function
info breakpoints          # List all breakpoints
delete <num>              # Delete breakpoint number
disable <num>             # Disable breakpoint
enable <num>              # Enable breakpoint
```

### Inspecting Variables
```
print (p) <variable>      # Print variable value
print *ptr                # Dereference pointer
print array[0]@10         # Print 10 elements of array
display <variable>        # Auto-display variable on each stop
info locals               # Show local variables
info args                 # Show function arguments
```

### Call Stack
```
backtrace (bt)            # Show call stack
frame <num>               # Switch to frame number
up                        # Move up one frame
down                      # Move down one frame
info frame                # Info about current frame
```

### Memory and Registers
```
x/<format> <address>      # Examine memory
x/10i $pc                 # Disassemble 10 instructions
info registers            # Show all registers
```

### Useful Settings
```
set print pretty on       # Pretty print structures
set print array on        # Print arrays nicely
set print elements 0      # Print all array elements
set args arg1 arg2        # Set program arguments
show args                 # Show current arguments
```

## Workshop Exercises

### Exercise 1: Debug `demo1_buggy_sum.cpp`
1. Set a breakpoint at the `buggy_sum` function
2. Run the program with argument `3`
3. Step through the loop and observe the variable `i`
4. Notice when `i` exceeds the vector bounds
5. Fix the bug and recompile

### Exercise 2: Analyze `demo2_segfault.cpp`
1. Run the program and observe the crash
2. Use `backtrace` to see where it crashed
3. Examine the pointer value with `print p`
4. Understand why dereferencing `nullptr` causes SIGSEGV
5. Fix the bug

### Exercise 3: Find All Bugs in `assignment.cpp`
1. Compile with debug symbols: `g++ -g -o assignment assignment.cpp`
2. Run with different command-line arguments
3. Use GDB to find each bug systematically
4. Document each bug you find
5. Fix all bugs and verify the program works correctly

## Tips for Effective Debugging

1. **Always compile with debug symbols:** Use `-g` flag
   ```bash
   g++ -g -o program program.cpp
   ```

2. **Use breakpoints strategically:** Set breakpoints before suspected bug locations

3. **Inspect variables frequently:** Use `print` and `display` to watch variables

4. **Check the call stack:** Use `backtrace` to understand how you got to the crash

5. **Read error messages carefully:** GDB provides helpful information about crashes

6. **Use conditional breakpoints:**
   ```
   break file.cpp:42 if i == 5
   ```

## Troubleshooting

### macOS: "Unable to find Mach task port"
If you see this error on macOS, you need to code-sign GDB. Run:
```bash
./install-mac.sh
```

### Core dumps not generated
On Linux, ensure core dumps are enabled:
```bash
ulimit -c unlimited
```

### GDB not found
Make sure GDB is in your PATH:
```bash
which gdb
```

If not found, add it to your PATH or use the full path.

## Resources

- [GDB Documentation](https://www.gnu.org/software/gdb/documentation/)
- [GDB Tutorial](https://www.gnu.org/software/gdb/documentation/)
- [Debugging with GDB Book](https://sourceware.org/gdb/current/onlinedocs/gdb/)

## License

This workshop material is provided for educational purposes.
