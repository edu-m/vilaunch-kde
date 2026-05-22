# Launch Countdown — KDE Plasma 6 Widget

A sleek desktop countdown widget for KDE Plasma 6. Configurable target date, accent color, and footer label.

![preview](./preview.png)

## Requirements

- **KDE Plasma 6** (Plasma 5 is not supported — uses the new `PlasmoidItem` API)
- **Qt 6**
- *(Optional)* Font **"Big Shoulders Stencil Display"** for the exact look. The widget falls back gracefully to a condensed sans-serif if it isn't installed.

### Install the optional font

Grab it from Google Fonts and drop the TTFs in your local font folder:

```bash
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts
# Download the family (use your browser, or:)
wget "https://fonts.google.com/download?family=Big%20Shoulders%20Stencil%20Display" -O big-shoulders.zip
unzip -j big-shoulders.zip "static/*Light*.ttf" "static/*Regular*.ttf"
fc-cache -f ~/.local/share/fonts
```

(Arch users: `sudo pacman -S ttf-google-fonts-git` also works.)

## Install the widget

### Option A — Drop-in install (recommended)

```bash
# From the folder containing this README:
kpackagetool6 --type Plasma/Applet --install local.launchcountdown
```

Then **right-click your desktop → "Add Widgets…" → search "Launch Countdown" → drag onto desktop.**

### Option B — Install from .plasmoid file

If you downloaded `LaunchCountdown.plasmoid`:

1. Right-click desktop → **Add Widgets…**
2. Click **Get New Widgets… → Install Widget from Local File…**
3. Pick `LaunchCountdown.plasmoid`
4. Find "Launch Countdown" in the widget list, drag it onto your desktop

### Option C — Manual install

Copy the folder into your local plasmoid path:

```bash
mkdir -p ~/.local/share/plasma/plasmoids/
cp -r local.launchcountdown ~/.local/share/plasma/plasmoids/
kquitapp6 plasmashell && kstart plasmashell
```

## Configure

Right-click the widget → **Configure Launch Countdown…**

| Setting | Default | Notes |
|---|---|---|
| Target date | `2026-11-19T00:00:00` | ISO format, local time |
| Footer label | `LAUNCH` | Shown after the date in the footer bar |
| Accent color | `#19d2ff` | Hex; applied to the numerals |
| Show footer | on | Toggle the bottom bar |
| Show seconds | on | Hide for a calmer ticker |

## Uninstall

```bash
kpackagetool6 --type Plasma/Applet --remove local.launchcountdown
```

## Update after editing

If you tweak the QML:

```bash
kpackagetool6 --type Plasma/Applet --upgrade local.launchcountdown
# then either re-add the widget, or:
kquitapp6 plasmashell && kstart plasmashell
```

## Troubleshooting

**Widget doesn't appear in "Add Widgets":** run `kbuildsycoca6` and reopen the panel.

**Crashes / blank widget:** check `journalctl --user -f` while plasmashell starts. Most often it's a Plasma 5 vs 6 mismatch — this widget is **Plasma 6 only**.

**Font looks plain:** Big Shoulders Stencil Display isn't installed. See the font section above, or edit `contents/ui/main.qml` and change `stencilFamily` to any condensed display font you have.

## License

MIT — do what you like.
