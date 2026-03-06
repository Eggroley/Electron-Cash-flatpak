# Discretion is advised

Packaging was made possible by Claude, Qwen, and GLM. There is no discernment between slop and good practices.

# Electron-Cash Flatpak

Flatpak packaging for [Electron-Cash](https://www.electroncash.org/).

## Features

- Full SPV wallet for Bitcoin Cash
- CashFusion support with bundled Tor
- Hardware wallet support (Trezor, Ledger, KeepKey, Satochip)
- QR code scanning
- System tray icon support (KDE, GNOME)

## Prerequisites

Install Flatpak and flatpak-builder:

```bash
# Ubuntu/Debian
sudo apt install flatpak flatpak-builder

# Fedora
sudo dnf install flatpak flatpak-builder

# Arch Linux
sudo pacman -S flatpak flatpak-builder
```

## Clone with Submodules

**Important:** This repository uses a git submodule for `shared-modules`. Clone with:

```bash
# Clone with submodules
git clone --recurse-submodules https://github.com/Eggroley/Electron-Cash-flatpak.git

# Or if already cloned, initialize submodules:
git submodule update --init --recursive
```

## Build

The `--install-deps-from=flathub` flag automatically downloads required runtimes:

```bash
cd flatpak
flatpak-builder --user --install-deps-from=flathub --force-clean build org.electroncash.ElectronCash.yml
```

Or use the build script which handles everything:

```bash
cd flatpak
./build.sh
```

### Install

```bash
flatpak-builder --user --install --force-clean build org.electroncash.ElectronCash.yml
```

## Run

```bash
flatpak run org.electroncash.ElectronCash
```

Or launch from your application menu.

## Bundle (for distribution)

```bash
flatpak-builder --user --force-clean --repo=repo build org.electroncash.ElectronCash.yml
flatpak build-bundle repo Electron-Cash.flatpak org.electroncash.ElectronCash
```

## Updating to a New Version

### 1. Get the new version SHA256

```bash
curl -sL https://github.com/Electron-Cash/Electron-Cash/archive/refs/tags/4.4.4.tar.gz | sha256sum
```

### 2. Update `org.electroncash.ElectronCash.yml`

Edit lines 163-164 with new version and SHA256:

```yaml
sources:
  - type: archive
    url: https://github.com/Electron-Cash/Electron-Cash/archive/refs/tags/4.4.4.tar.gz
    sha256: <paste-new-sha256-here>
```

### 3. Update `org.electroncash.ElectronCash.metainfo.xml`

Add new release at the top of `<releases>`:

```xml
<release version="4.4.4" date="2026-XX-XX">
  <url type="details">https://github.com/Electron-Cash/Electron-Cash/releases/tag/4.4.4</url>
  <description>
    <p>Description of changes</p>
  </description>
</release>
```

### 4. Build and test

```bash
flatpak-builder --user --install-deps-from=flathub --force-clean build org.electroncash.ElectronCash.yml
flatpak run org.electroncash.ElectronCash --version
```

### 5. Commit changes

```bash
git add org.electroncash.ElectronCash.yml org.electroncash.ElectronCash.metainfo.xml
git commit -m "Update to Electron-Cash 4.4.4"
git push origin master
```

## Files

```
org.electroncash.ElectronCash.yml          # Main manifest
org.electroncash.ElectronCash.metainfo.xml # AppStream metadata
org.electroncash.ElectronCash.desktop      # Desktop entry
python3-requirements.json                  # Python dependencies
python3-requirements-binaries.json         # Binary wheels
flathub.json                               # Architecture configuration
shared-modules/                            # Git submodule (libusb)
tray-icon-fix.patch                        # Tray icon fix
build.sh                                   # Build helper script
```