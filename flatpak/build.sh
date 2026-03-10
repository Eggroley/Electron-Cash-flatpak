#!/bin/bash
# Build script for Electron-Cash Flatpak
# Automatically installs required runtimes from Flathub

set -e

REMOTE="flathub"
MANIFEST="org.electroncash.ElectronCash.yml"

echo "=== Electron-Cash Flatpak Build ==="
echo ""

# Check if flathub remote exists
if ! flatpak remote-list | grep -q "^${REMOTE}"; then
    echo "Adding Flathub remote..."
    flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
fi

# Check for required runtimes and suggest install if missing
check_runtime() {
    local runtime=$1
    if ! flatpak list --runtime | grep -q "${runtime}"; then
        echo "Runtime ${runtime} not found."
        echo "Will be automatically installed from ${REMOTE} during build."
    else
        echo "✓ ${runtime} installed"
    fi
}

echo "Checking runtimes..."
check_runtime "org.kde.Platform/x86_64/5.15-24.08"
check_runtime "org.kde.Sdk/x86_64/5.15-24.08"
check_runtime "com.riverbankcomputing.PyQt.BaseApp/x86_64/5.15-24.08"
echo ""

# Check for submodules
if [ ! -f "shared-modules/libusb/libusb.json" ]; then
    echo "Error: Git submodules not initialized."
    echo "Run: git submodule update --init --recursive"
    exit 1
fi

echo "Building Flatpak..."
echo "This will automatically download and install missing runtimes from Flathub."
echo ""

# Build with automatic dependency installation from Flathub
flatpak-builder --user --install-deps-from=${REMOTE} --force-clean build ${MANIFEST} "$@"

echo ""
echo "Build complete!"