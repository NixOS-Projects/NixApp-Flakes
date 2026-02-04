# NixApp-Flakes

### Download the repository
```
git clone https://github.com/NixOS-Projects/NixApp-Flakes.git
```

### Enter into an app
```
cd NixApp-Flakes/<app>
```

### Run the app
```
nix develop
```

#### !! IMPORTANT !! Add these lines in your configuration.nix
> nix.settings.experimental-features = [ "nix-command" "flakes" ];
