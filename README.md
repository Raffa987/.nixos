#WIP
# ❄️ My NixOS Configuration

A unified and reproducible NixOS configuration managed via **Flakes** and **Home Manager**.
<img width="1920" height="1200" alt="image" src="https://github.com/user-attachments/assets/e5c7531c-5529-49a9-b415-b201d269b385" />


## ✨ Custom Features & Keybinds

I have built some custom widgets and functionalities tailored to my workflow:

* **`Super + \`** (Win + \\): Opens a drop-down mini terminal in the top-right corner.
* **`Alt + Z`**: Toggles a hardware statistics widget (CPU, RAM, etc.) in the top-right corner. 
    > **Note:** This hardware widget relies on a custom library. You can find it in my other repository here: *[https://github.com/Raffa987/libmystats]*

## 🛠️ Tech Stack

* **OS:** NixOS (Flakes enabled)
* **WM:** Hyprland
* **Bar/Widgets:** AGS (Aylur's GTK Shell)
* **Terminal:** Kitty
* **Shell:** Fish
* **Fetch:** Fastfetch

## 📂 Repository Structure

This repository contains both system-level configurations and user-level dotfiles:

* `/` - System configuration files (`flake.nix`, `configuration.nix`)
* `/home-manager/` - Nix modules for user programs and dependencies
* `/dotfiles/` - Raw configuration files (Hyprland, AGS, Kitty) linked via Home Manager's `mkOutOfStoreSymlink` for instant live-reloading.

## 🚀 How to Apply

To build the system from this Flake, run:

```bash
# Navigate to the directory
cd ~/.nixos

# Rebuild the system and apply Home Manager configurations
sudo nixos-rebuild switch --flake .#your-hostname
