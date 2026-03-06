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

## Submit to Flathub

1. Fork https://github.com/flathub/flathub
2. Clone your fork: `git clone --branch=new-pr git@github.com:YOUR_USERNAME/flathub.git`
3. Create branch: `git checkout -b add-electron-cash new-pr`
4. Copy this directory to `apps/org.electroncash.ElectronCash/` in the flathub repo
5. Commit and push: `git push -u origin add-electron-cash`
6. Open a pull request against the `new-pr` branch (NOT master)

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
