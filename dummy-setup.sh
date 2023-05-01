#!/bin/bash


# create local dummy repository
mkdir "my-local-repo"
ostree init --mode bare-user-only --repo="my-local-repo"


# create dummy runtime
mkdir my-runtime
mkdir -p my-runtime/files
mkdir -p my-runtime/usr

cat > my-runtime/metadata << EOF
[Runtime]
name=local.dummy.BasePlatform
runtime=local.dummy.BasePlatform/x86_64/empty
sdk=local.dummy.BaseSdk/x86_64/empty
EOF


# create dummy SDK
mkdir my-sdk
mkdir -p my-sdk/files/x86_64-unknown-linux-gnu/
mkdir -p my-sdk/usr

cat > my-sdk/metadata << EOF
[Runtime]
name=local.dummy.BaseSdk
runtime=local.dummy.BasePlatform/x86_64/empty
sdk=local.dummy.BaseSdk/x86_64/empty
EOF


# install dummy runtime and sdk
flatpak build-export my-local-repo/ my-runtime/
flatpak build-export my-local-repo/ my-sdk/

flatpak remote-add --user --no-gpg-verify my-local-repo "file://$(pwd)/my-local-repo"

flatpak install --user my-local-repo local.dummy.BasePlatform
flatpak install --user my-local-repo local.dummy.BaseSdk
