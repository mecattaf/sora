# Sora Linux

[![build-ublue](https://github.com/ublue-os/startingpoint/actions/workflows/build.yml/badge.svg)](https://github.com/ublue-os/startingpoint/actions/workflows/build.yml)

## Install

- First rebase to the unsigned image, to get the proper signing keys and policies installed:
  ```
  sudo rpm-ostree rebase ostree-unverified-registry:ghcr.io/mecattaf/sora:latest
  ```

- Reboot to complete the rebase:
  ```
  systemctl reboot
  ```
- Then rebase to the signed image, like so:
  ```
  sudo rpm-ostree rebase ostree-image-signed:docker://ghcr.io/mecattaf/sora:latest
  ```
- Reboot again to complete the installation
  ```
  systemctl reboot
  ```

### Set up dotfiles for my device
```
git clone https://github.com/mecattaf/sora
cd sora
./setup-sora.sh
```

### Manual setup using GUI

- Run `nwg-look` and set up appearance settings
- Run `azote` and pick wallpaper
- Run 'nautilus' and set hidden files to "show"

### Google Chrome

1) In `chrome://settings`:

System

- Continue running background apps when Google Chrome is closed ❌
- Use hardware acceleration when available ✅

Appearance

- Theme: `All Black - Full Dark Theme/Black Theme`
- Mode: `Dark`
- Show home button ❌
- Show bookmarks bar ❌
- Show images on tab hover preview cards ✅
- Use system title bars and borders ✅

2) In`chrome://flags`:

- Preferred Ozone Platform: `Wayland`
- Chrome Refresh 2023 ✅
- Realbox Chrome Refresh 2023 ✅
- Chrome WebUI Refresh 2023 ✅
- Chrome Refresh 2023 New Tab Button ✅
- Enable Display Compositor to use a new gpu thread ✅
- WebRTC PipeWire support ✅
- Native Client ✅
- WebGL Developer Extensions ✅
- WebGL Draft Extensions✅
- Toggle hardware accelerated H.264 video encoding for Cast Streaming ✅
- Toggle hardware accelerated VP8 video encoding for Cast Streaming ✅

## Verification

These images are signed with sisgstore's [cosign](https://docs.sigstore.dev/cosign/overview/). You can verify the signature by downloading the `cosign.pub` key from this repo and running the following command:

    cosign verify --key cosign.pub ghcr.io/mecattaf/SericeaFX

If you're forking this repo, the uBlue website has [instructions](https://ublue.it/making-your-own/) for setting up signing properly.

### To revert back to Silverblue

```shell
sudo rpm-ostree rebase fedora:fedora/38/x86_64/silverblue
```


