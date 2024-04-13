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

## Sign auto-generated tar.gz tarball on releases (on GitHub, GitLab, Gitea...)

Download the tarball locally and sign it via:

```bash
gpg --armor --detach-sign tarball.tar.gz
```

Upload the `tarball.tar.gz.asc` file produced by the above command as an attachment of the release.
