# template-dotfiles

`dotfiles` are a way to customise your development environment according to your personal needs. 

> [!CAUTION]
> Do not save secrets, passwords, or API keys in your `dotfiles`. Instead, follow [the engineering handbook guidance for storing development secrets.](https://docs.canva.tech/security/development-secrets/)

## Getting started

- Create a new create a new canvanauts repository using this repository as a template via [this link](https://github.com/canvanauts/template-dotfiles/generate) or do it manually as per below...

<img width="599" src="https://github.com/Canva/infrastructure/assets/127353/da1b9443-eba2-4cd2-b78f-995aee7b33c1">

- Configure this repository into your `devbox` workspace settings as your `dotfiles`.

## How to use

When a `debox` starts it automatically clones the repository that you configure as your dotfiles and executes `install.sh`.

What `install.sh` does is up to you!

This template is built using the GNU `stow` symlink manager.

- `editorconfig/.editorconfig` -> symlinks to `~/.editorconfig`
- `git/.gitconfig` -> symlinks to `~/.gitconfig`
- `gh/.config/gh/config.yaml` -> symlinks to `~/.config/gh/config.yaml`

```
$ ls -al ~/

total 92
drwxr-xr-x 14 ghuntley ghuntley  4096 Nov  8 13:28 .
drwxr-xr-x  4 root     root      4096 Nov  8 11:34 ..
drwxr-xr-x  2 ghuntley ghuntley  4096 Nov  8 11:35 .aws
lrwxrwxrwx  1 ghuntley ghuntley    46 Nov  8 13:28 .bash_profile -> .dotfiles/bash/.bash_profile
drwxr-xr-x  3 ghuntley ghuntley  4096 Nov  8 13:27 .dotfiles
lrwxrwxrwx  1 ghuntley ghuntley    54 Nov  8 13:28 .editorconfig -> .dotfiles/editorconfig/.editorconfig
```

With `stow` you can edit your files ie

`$ vim ~/.gitconfig`

As per normal but as they are symlinks the contents will be read/written to your dotfiles git repository. Once you are happy with the changes you'll need to git commit and push the changes for them to be persisted.

```
$ cd ~/.dotfiles
$ git add -Ap
$ # check to ensure you aren't commiting secrets
$ git commit -m "big crazy goats" && git push origin
```

If you want to delete the `editorconfig` configuration then delete the folder and the `stow editorconfig -t ~` line in `install.sh`

## Advanced

`install.sh` is the entry point. This file must be executable (ie `chmod u+x install.sh`) and is run by devboxes when they start. You can do nearly anything in here but the rule of thumb here is for any actions that are executed must be able to be executed multiple times (ie. idempotent) without erroring out.

## Troubleshooting

If your `dotfiles` fails installation then you can determine the _why_ via:

```bash
$ journalctl -fu devbox@coder.service
```

If you want to get a devloop going either run `install.sh` manually or run the systemd unit `$ sudo systemctl start devbox@coder.service`

## Recommended reading

- [Managing dotfiles with GNU Stow](https://venthur.de/2021-12-19-managing-dotfiles-with-stow.html)
- [@ghuntley does dotfiles](https://github.com/ghuntley/dotfiles)

