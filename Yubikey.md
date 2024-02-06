# Yubikey

## SSH with PIV

### Install pre-requisites

```bash
sudo pacman -S ccid yubico-piv-tool openssh
sudo systemctl enable --now pcscd
systemctl --user enable --now ssh-agent.service
```

### Change default PIN/PUK/Management key (if not done already)

```bash
yubico-piv-tool -a change-pin
yubico-piv-tool -a change-puk
yubico-piv-tool -a set-mgm-key -k
```

### Generating a SSH key

```bash
ssh-keygen -t ecdsa -C "Comment" -f id_ecdsa
cp id_ecdsa id_ecdsa.pem
ssh-keygen -p -f id_ecdsa.pem -m pem
```

### Import key to Yubikey

Replace SLOT by the one you want to import the key to.  
Check [this link](https://docs.yubico.com/yesdk/users-manual/application-piv/slots.html) for a list of available slots.

```bash
yubico-piv-tool -s SLOT -a import-key -i id_ecdsa.pem --pin-policy=once --touch-policy=cached -k
```

### Add the PKCS11 provider to the ssh-agent and config

```bash
ssh-add -D && ssh-add -s /usr/lib/libykcs11.so
vim ~/.ssh/config
```

> PKCS11Provider /usr/lib/libykcs11.so
> [...]  

**Warning:** The default value of `MaxAuthTries` for the SSH daemon is "6", meaning that the SSH connection will fail after 6 failed attempts.  
That means that if you have more than 6 keys on your Yubikey, each key imported in a slot located after the 6 first ones on the Yubikey will cause the SSH connection to fail because of maximum tries being exceeded (since SSH tries each key stored on the Yubikey one by one until it finds the good one for the remote host).

To prevent that, you can either increase the value of the `MaxAuthTries` parameter in the SSH daemon config (which obviously involves having root access to the remote machine) or re-import the needed key in an "earlier/lower" slot on the Yubikey (be aware that importing a key on a already used slot overwrite the key that is currently stored on it).  
*Note: since v2.5.0, `yubico-piv-tool` have a feature to move keys between slots with the `move-key` action instead of having to re-import keys. However, you need a recent enough Yubikey with a recent firmware to use that option.*
