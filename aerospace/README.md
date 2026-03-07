# 🪐 AeroSpace Config — Keyboard Ninja Edition

Welcome to my **AeroSpace tiling window manager configuration** for macOS.
This setup turns macOS into something closer to **i3 / sway levels of keyboard wizardry** while keeping the native macOS ecosystem.

Think:

⚡ fast window management
⌨️ keyboard-first workflow
🧠 minimal mental overhead
✨ clean UI with SketchyBar

If you like **tiling window managers and Vim-style navigation**, you're in the right place.

---

# 🚀 Startup Magic

When AeroSpace launches, it automatically fires up a few companions:

* **SketchyBar** → the stylish system bar
* **Borders** → beautiful window borders

```toml
after-startup-command = [
  'exec-and-forget sketchybar',
  'exec-and-forget borders'
]
```

This means your desktop comes alive immediately.

---

# 🎯 Workspace Awareness

Whenever the active workspace changes, AeroSpace politely informs **SketchyBar** so the bar can update the UI.

```toml
exec-on-workspace-change = [
  '/bin/bash',
  '-c',
  'sketchybar --trigger aerospace_workspace_change FOCUSED_WORKSPACE=$AEROSPACE_FOCUSED_WORKSPACE'
]
```

Result:

✨ active workspace highlight
✨ responsive status bar
✨ visual sanity

---

# 🧱 Window Layout Philosophy

This config keeps the layout predictable and tidy.

```toml
enable-normalization-flatten-containers = true
enable-normalization-opposite-orientation-for-nested-containers = true
```

Translation:

* containers don't get weird
* nested layouts stay readable
* windows behave logically

---

# 🧩 Layout System

Default layout:

```
Tiles
```

But you can switch to:

```
Accordion
```

Settings:

```toml
accordion-padding = 30
default-root-container-layout = 'tiles'
default-root-container-orientation = 'auto'
```

So the layout automatically adapts to your screen.

---

# 🖱 Focus Behavior

When switching monitors:

```toml
on-focused-monitor-changed = ['move-mouse monitor-lazy-center']
```

Your cursor jumps to the center of the monitor.

No more **mouse teleportation confusion**.

---

# 🧙 macOS App Fix

macOS sometimes hides apps in weird ways.
This config prevents that.

```toml
automatically-unhide-macos-hidden-apps = true
```

Apps behave like normal human software again.

---

# ⌨ Keyboard Layout

```toml
[key-mapping]
preset = 'qwerty'
```

Keybindings are designed around **QWERTY keyboards**.

---

# 🪟 Window Gaps

Clean breathing room between windows.

```toml
[gaps]
inner.horizontal = 10
inner.vertical = 10
outer.left = 80
outer.bottom = 10
outer.top = 10
outer.right = 10
```

### Why 80px on the left?

That's reserved space for a **vertical SketchyBar sidebar**.

Because aesthetics matter.

---

# 🖥 Workspace → Monitor Mapping

```toml
[workspace-to-monitor-force-assignment]
7 = 'secondary'
8 = 'secondary'
9 = 'secondary'
```

My setup:

| Monitor   | Workspaces |
| --------- | ---------- |
| Main      | 1–6        |
| Secondary | 7–9        |

No accidental window chaos across screens.

---

# 🧠 Keybindings

All main shortcuts use **ALT**.

---

# 🧭 Navigation (Vim Style)

Move between windows like a Vim wizard.

| Key     | Action      |
| ------- | ----------- |
| Alt + H | focus left  |
| Alt + J | focus down  |
| Alt + K | focus up    |
| Alt + L | focus right |

Once you learn this, **mouse navigation feels primitive**.

---

# 📦 Move Windows

Rearrange the layout instantly.

| Key             | Action     |
| --------------- | ---------- |
| Alt + Shift + H | move left  |
| Alt + Shift + J | move down  |
| Alt + Shift + K | move up    |
| Alt + Shift + L | move right |

---

# 📏 Resize Windows

Adjust window sizes dynamically.

| Key     | Action |
| ------- | ------ |
| Alt + - | shrink |
| Alt + = | grow   |

Resize amount = **50px**

---

# 🌍 Workspaces

Switch between them instantly.

| Key         | Action           |
| ----------- | ---------------- |
| Alt + 1 → 9 | switch workspace |

---

# 🚚 Move Window to Workspace

| Key                 | Action                   |
| ------------------- | ------------------------ |
| Alt + Shift + 1 → 9 | move window to workspace |

Perfect for organizing your chaos.

---

# 🔁 Workspace Tricks

| Key               | Action                         |
| ----------------- | ------------------------------ |
| Alt + Tab         | jump to previous workspace     |
| Alt + Shift + Tab | move workspace to next monitor |

Great for **multi-monitor setups**.

---

# 🔗 Container Magic

Combine windows into containers.

| Key            | Action     |
| -------------- | ---------- |
| Ctrl + Alt + H | join left  |
| Ctrl + Alt + J | join down  |
| Ctrl + Alt + K | join up    |
| Ctrl + Alt + L | join right |

Very useful for advanced layouts.

---

# 🛠 Service Mode

Enter **service mode** with:

```
Alt + Shift + ;
```

This unlocks administrative controls.

---

## Service Mode Commands

| Key       | Action                           |
| --------- | -------------------------------- |
| Esc       | reload config                    |
| R         | reset layout                     |
| F         | toggle floating / tiling         |
| Backspace | close all windows except current |

---

## Volume Controls

Because convenience is king.

| Key       | Action      |
| --------- | ----------- |
| ↓         | volume down |
| ↑         | volume up   |
| Shift + ↓ | mute        |

---

# 🧑‍💻 Typical Workflow

My daily flow looks like this:

1️⃣ Launch apps
2️⃣ Send them to workspaces
3️⃣ Navigate with **H J K L**
4️⃣ Resize windows quickly
5️⃣ Use service mode when needed

Minimal friction. Maximum focus.

---

# 📦 Dependencies

You'll need:

* **AeroSpace**
* **SketchyBar**
* **Borders**

Recommended:

* **Nerd Fonts** (for icons)

---

# 🧠 Design Philosophy

This setup aims for:

* keyboard-first control
* minimal mouse usage
* predictable layouts
* visual cleanliness
* left vertical sketchybar

Basically:

> make macOS behave like a proper tiling WM.

---

# 🧃 Final Thoughts

Once you get used to this workflow:

💻 windows move instantly
⚡ context switching becomes effortless
🧠 your brain stays focused on actual work

And suddenly...

**the mouse feels slow.**

