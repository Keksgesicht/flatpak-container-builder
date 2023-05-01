# Flatpak Container Builder

## Setup

```sh
mkdir my-flatpak-build-dir
cd my-flatpak-build-dir
../dummy-setup.sh
```

## Convert Docker Image to Flatpak Application

```sh
docker export $(docker create localhost/awesome-tool) | tar -xC my-flatpak-build-dir/tmp/awesome-tool/files
flatpak build-finish my-flatpak-build-dir/tmp/awesome-tool
```
