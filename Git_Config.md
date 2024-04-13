# Git Configuration

## Global Identity

```bash
git config --global user.name "My Name"
git config --global user.email "myemail@example.com"
```

You can overwrite those settings at a repo level by removing the `--global` flag.

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
sha256sums tarball.tar.gz > tarball.tar.gz.sha256
gpg --local-user D33FAA16B937F3B2 --armor --detach-sign tarball.tar.gz.sha256
```

Upload the `tarball.tar.gz.asc`, `tarball.tar.gz.sha256` & `tarball.tar.gz.sha256.asc` files produced by the above commands as an attachment of the release.
