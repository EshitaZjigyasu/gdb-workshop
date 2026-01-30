#!/bin/bash

# GDB Installation Script for macOS
# This script installs GDB and sets up code signing if needed

set -e

echo "=== GDB Installation Script for macOS ==="
echo ""

# Check if Homebrew is installed
if ! command -v brew &> /dev/null; then
    echo "Error: Homebrew is not installed."
    echo "Please install Homebrew first: https://brew.sh"
    exit 1
fi

# Install GDB
echo "Installing GDB via Homebrew..."
brew install gdb

# Check if GDB was installed successfully
if ! command -v gdb &> /dev/null; then
    echo "Error: GDB installation failed."
    exit 1
fi

echo ""
echo "GDB installed successfully!"
echo ""

# Check if code signing is needed
GDB_PATH=$(which gdb)
echo "GDB location: $GDB_PATH"
echo ""

# Create a certificate for code signing if needed
echo "Setting up code signing for GDB..."
echo "This is required on macOS to allow GDB to attach to processes."
echo ""

# Check if certificate already exists
if security find-certificate -c "gdb-cert" &> /dev/null; then
    echo "Certificate 'gdb-cert' already exists. Skipping certificate creation."
else
    echo "Creating a self-signed certificate for GDB..."
    echo ""
    echo "Please follow these steps:"
    echo "1. Open Keychain Access.app"
    echo "2. Go to Keychain Access > Certificate Assistant > Create a Certificate"
    echo "3. Name: gdb-cert"
    echo "4. Identity Type: Self Signed Root"
    echo "5. Certificate Type: Code Signing"
    echo "6. Check 'Let me override defaults'"
    echo "7. Continue through the wizard"
    echo "8. When asked 'Specify a Location For The Certificate', select 'System'"
    echo "9. Click 'Create'"
    echo ""
    read -p "Press Enter after you've created the certificate..."
fi

# Code sign GDB
echo ""
echo "Code signing GDB..."
sudo codesign --entitlements - --force --sign gdb-cert "$GDB_PATH"

if [ $? -eq 0 ]; then
    echo "GDB has been code signed successfully!"
else
    echo "Warning: Code signing failed. You may need to:"
    echo "1. Create the certificate manually (see instructions above)"
    echo "2. Run: sudo codesign --entitlements - --force --sign gdb-cert $GDB_PATH"
fi

echo ""
echo "=== Installation Complete ==="
echo ""
echo "To verify installation, run:"
echo "  gdb --version"
echo ""
echo "If you encounter 'Unable to find Mach task port' errors,"
echo "you may need to create the certificate manually (see instructions above)."
