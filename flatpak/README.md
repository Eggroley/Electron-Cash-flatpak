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

## Build

```bash
flatpak-builder --user --install --force-clean build org.electroncash.ElectronCash.yml
```

## Run

```bash
flatpak run org.electroncash.ElectronCash
```

Or launch from your application menu.

## Bundle

```bash
flatpak build-bundle repo Electron-Cash.flatpak org.electroncash.ElectronCash
```

## Files

```
org.electroncash.ElectronCash.yml          # Main manifest
org.electroncash.ElectronCash.metainfo.xml  # AppStream metadata
org.electroncash.ElectronCash.desktop   # Desktop entry
python3-requirements.json               # Python dependencies
python3-requirements-binaries.json      # Binary wheels (cryptography, cffi, zxing-cpp)
flathub.json                            # Architecture configuration
shared-modules/                         # Git submodule (libusb)
tray-icon-fix.patch                     # System tray icon fix
icons/                                 # Icon files
```
