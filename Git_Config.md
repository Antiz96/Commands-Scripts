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

gofsdhgodfhgofdghofd
