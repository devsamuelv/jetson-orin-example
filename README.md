# Jetson Orin Nix Example

The jetpack-nixos package provided by Andurill does not have any example projects listed. So, I decided to create my own based around c++ and cmake. I expect to be doing a lot of embedded system development in the future regarding autnomous systems. So I want to have a solid framework that will allow me to focus on writing code rather than worrying about dependency management or deployment.

## Getting Started

To start developing using the project you will need to setup the local development environment. Using `nix develop` it will setup a bash shell with all the libraries added directly into the `$PATH`. After its done you should have a usable envronment to develop in.

> [!NOTE]
> If you are using VSCode I recommend the [nix-env-selector](https://marketplace.visualstudio.com/items?itemName=arrterian.nix-env-selector) by Roman Valihura. Its an extension that will automatically load your nix devshell into vscode.
