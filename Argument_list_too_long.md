# List too long

When there's too much files in a directory (usually +10 000), some Linux commands don't work anymore.  
Here's a useful command to bypass this limitation (the idea is to execute the command on each files separately instead of execute it on all files at the same time):

```bash
for i in /path/*; do command $i; done
```

Example with a `chown` command:

```bahs
for i in /path/*; do chown root:root $i; done
```

Alternatively, you can copy the file list to a temporary file and use a while loop to treat them 1 by 1:

```bash
find /path/ > /tmp/file_list.txt
while read line; do cp -rp "$line" /backup/; done < /tmp/file_list.txt
```
