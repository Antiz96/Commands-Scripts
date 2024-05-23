# Git Configuration

## Global Identity

```bash
git config --global user.name "My Name"
git config --global user.email "myemail@example.com"
```

You can overwrite those settings at a repo level by removing the `--global` flag.

## Global alias

```bash
echo -e '[alias]\n        upgrade = "!f(){ current_branch=$(git rev-parse --abbrev-ref HEAD) ; if [ -n \"$1\" ]; then main_branch=\"$1\"; else main_branch="main"; fi ; git switch \"$main_branch\" && git pull && git branch -d \"$current_branch\"; };f"' >> ~/.gitconfig
```

## Auto-create non existing branch on remote when pushing

```bash
git config --global push.autoSetupRemote true
```

## Automatically sign commits for the current repo

```bash
git config commit.gpgsign true
```

## Automatically sign tags for the current repo

```bash
git config tag.gpgSign true
```

## Sign auto-generated tar.gz tarball + checksum on releases (on GitHub, GitLab, Gitea...)

*Not git related, but I'm using this on git releases for my projects.*

Download the tarball locally and sign it:

```bash
gpg --local-user D33FAA16B937F3B2 --armor --detach-sign tarball.tar.gz
```

Generate checksum file for the tarball and sign it:

```bash
sha256sum tarball.tar.gz > tarball.tar.gz.sha256
gpg --local-user D33FAA16B937F3B2 --armor --detach-sign tarball.tar.gz.sha256
```

Upload the `tarball.tar.gz.asc`, `tarball.tar.gz.sha256` & `tarball.tar.gz.sha256.asc` files produced by the above commands as an attachment of the release.
