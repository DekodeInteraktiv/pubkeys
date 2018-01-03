#!/bin/bash

for PUBKEY_FILE in `ls keys/*.pub`; do
	if [ ! -f $PUBKEY_FILE.gpg ]; then
		echo "Signing  $PUBKEY_FILE"
		gpg --output $PUBKEY_FILE.gpg --detach-sig $PUBKEY_FILE
	fi
done

echo "Concatenating all public keys into authorized_keys"
awk 'FNR==1{print ""}1' keys/*.pub > authorized_keys

echo "Creating checksum file of all public keys: SHA256SUMS"
shasum -a 256 keys/*.pub > SHA256SUMS

echo "Creating checksum file the authorized_keys file: authorized_keys.sha256"
shasum -a 256 authorized_keys > authorized_keys.sha256

echo "Signing the SHA256SUMS file"
gpg --output SHA256SUMS.gpg --detach-sig SHA256SUMS

echo "Signing the authorized_keys.sha256 file"
gpg --output authorized_keys.sha256.gpg --detach-sig authorized_keys.sha256

