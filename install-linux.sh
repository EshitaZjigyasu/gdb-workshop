#!/bin/bash

# GDB Installation Script for Linux
# Supports Ubuntu/Debian, Fedora/RHEL/CentOS, and Arch Linux

set -e

echo "=== GDB Installation Script for Linux ==="
echo ""

# Detect Linux distribution
if [ -f /etc/os-release ]; then
    . /etc/os-release
    DISTRO=$ID
else
    echo "Error: Cannot detect Linux distribution."
    exit 1
fi

echo "Detected distribution: $DISTRO"
echo ""

# Install based on distribution
case $DISTRO in
    ubuntu|debian)
        echo "Installing GDB and build tools for Ubuntu/Debian..."
        sudo apt-get update
        sudo apt-get install -y gdb g++ build-essential
        ;;
    fedora|rhel|centos)
        echo "Installing GDB and build tools for Fedora/RHEL/CentOS..."
        if command -v dnf &> /dev/null; then
            sudo dnf install -y gdb gcc-c++ make
        else
            sudo yum install -y gdb gcc-c++ make
        fi
        ;;
    arch|manjaro)
        echo "Installing GDB and build tools for Arch Linux..."
        sudo pacman -S --noconfirm gdb gcc make
        ;;
    *)
        echo "Warning: Unsupported distribution: $DISTRO"
        echo "Please install GDB manually:"
        echo "  Ubuntu/Debian: sudo apt-get install gdb g++ build-essential"
        echo "  Fedora/RHEL:   sudo dnf install gdb gcc-c++ make"
        echo "  Arch:          sudo pacman -S gdb gcc make"
        exit 1
        ;;
esac

# Verify installation
if command -v gdb &> /dev/null; then
    echo ""
    echo "GDB installed successfully!"
    echo ""
    echo "GDB version:"
    gdb --version
    echo ""
    echo "G++ version:"
    g++ --version
    echo ""
    echo "=== Installation Complete ==="
    echo ""
    echo "To enable core dumps, run:"
    echo "  ulimit -c unlimited"
else
    echo "Error: GDB installation failed."
    exit 1
fi
