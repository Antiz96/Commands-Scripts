# Checking for used disk space in a directory

```bash
du -h --max-depth=1 /path
```

# Same for AIX/KSH

```ksh
du -g /path | sort -nr | head
```

# Checking for used disk space excluding some directories 

*Useful to check `/` excluding mounted point.*

```bash
du -h --max-depth=1 / --exclude=/{dev,run,lib,usr,tmp,opt,boot,var}
```
