# NixApp-Flakes

### Install the repository
```
git clone <URL>
```

### Copy/Paste the flake files in your directory
```
cp <app>/flake.* <output>
```

### Enter into flake environment
```
nix develop
```

#### !! IMPORTANT !! Add these lines in your configuration.nix
> nix.settings.experimental-features = [ "nix-command" "flakes" ];
