#!/usr/bin/env bash
# Helper script — install the Launch Countdown plasmoid.
# Usage:  ./install.sh

set -e

PKG_DIR="$(cd "$(dirname "$0")" && pwd)"

if ! command -v kpackagetool6 >/dev/null 2>&1; then
    echo "ERROR: kpackagetool6 not found. This widget requires KDE Plasma 6."
    exit 1
fi

if kpackagetool6 --type Plasma/Applet --list 2>/dev/null | grep -q "local.vilaunch-kde"; then
    echo "Already installed — upgrading…"
    kpackagetool6 --type Plasma/Applet --upgrade "$PKG_DIR"
else
    kpackagetool6 --type Plasma/Applet --install "$PKG_DIR"
fi

echo ""
echo "Installed. Right-click your desktop -> Add Widgets… -> search 'Launch Countdown'."
echo "  (If it doesn't appear, run:  kbuildsycoca6  then reopen Add Widgets.)"
