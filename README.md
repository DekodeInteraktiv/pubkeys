## Modified/added/removed pubkeys

### Sign the key

`gpg --output keys/username.pub.gpg --detach-sig keys/username.pub`

### Generate a new `authorized_keys` file

`awk 'FNR==1{print ""}1' keys/*.pub > authorized_keys`

### Generate new checksum files

`shasum -a 256 keys/*.pub > SHA256SUMS`

`shasum -a 256 authorized_keys > authorized_keys.sha256`

### Sign the checksum files

`gpg --output SHA256SUMS.gpg --detach-sig SHA256SUMS`

`gpg --output authorized_keys.sha256.gpg --detach-sig authorized_keys.sha256`


## Verify the files

### Check signature of checksum files

`gpg --verify SHA256SUMS.gpg SHA256SUMS`

`gpg --verify authorized_keys.sha256.gpg authorized_keys.sha256`

### Verify checksum of all pubkeys

`shasum -a 256 -c SHA256SUMS`

### Verify checksum of the authorized_keys file

`shasum -a 256 -c authorized_keys.sha256`

