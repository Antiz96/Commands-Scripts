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

To prevent that, you can make your ssh config points to the corresponding **public** key (to avoid the need to have your private keys stored locally on your system, which would defeat the purpose of having a Yubikey) for your different hosts, instead of adding the PKCS11 provider directly. This will tell SSH to look directly for the corresponding private key in the ssh-agent (instead of trying all of them one by one):

```bash
vim ~/.ssh/config
```

```text
Host host-example-1
        IdentityFile ~/.ssh/id_ecdsa_host-example-1.pub

Host host-example-2
        IdentityFile ~/.ssh/id_ecdsa_host-example-2.pub
```
