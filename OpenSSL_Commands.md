# Display information

```bash
openssl x509 -text -noout -in xxxx.crt
openssl req -text -noout -in xxxx.csr
```

# Check for Modulus

```bash
openssl x509 -noout -modulus -in xxxx.crt
openssl req -noout -modulus -in xxxx.crs
openssl rsa -noout -modulus -in xxxx.key
```

# Check for Expiration Date

```bash
openssl x509 -enddate -noout -in xxxx.crt

#Keystore/Truststore/P12 (actually not openssl)
keytool -keystore xxxxx.jks -list
```

# Get a remote SSL certificate

```bash
openssl s_client -connect HOST:PORT
```

# Get all info and expiration date of SSL certificates stored in `pwd`

```bash
for i in "$(pwd)"/*.{crt,cer,pem}; do test -f "$i" && echo "$i" && openssl x509 -text -noout -in "$i" | grep -E "Not After :|Subject:|Issuer:" && echo ""; done
```
