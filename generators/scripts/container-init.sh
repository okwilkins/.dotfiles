# Script to aid starting the NixOS-generator for Docker when running the container
#!/sw/bin/bash
set -e

/activate 2>/dev/null || true
source /etc/profile

TARGET_USER=$(ls /home | head -n 1)

if [ -z "$TARGET_USER" ]; then
  echo "ERROR: No user directory found in /home. Cannot determine username."
  exit 1
fi

# Fix user database so su works
echo 'root:x:0:0::/root:/sw/bin/bash' > /etc/passwd
echo "${TARGET_USER}:x:1000:100::/home/${TARGET_USER}:/sw/bin/bash" >> /etc/passwd
echo 'root:x:0:' > /etc/group
echo 'users:x:100:' >> /etc/group
# Format: user:!:lastchg:min:max:warn:inactive:expire
# '!' means locked account (no password)
echo 'root:!:19700:0:99999:7:::' > /etc/shadow
echo "${TARGET_USER}:!:19700:0:99999:7:::" >> /etc/shadow

# Fix PAM
echo 'hosts: files dns' > /etc/nsswitch.conf
echo 'passwd: files' >> /etc/nsswitch.conf
echo 'group: files' >> /etc/nsswitch.conf
echo 'shadow: files' >> /etc/nsswitch.conf
mkdir -p /etc/pam.d
echo 'auth required pam_permit.so' > /etc/pam.d/su
echo 'account required pam_permit.so' >> /etc/pam.d/su
echo 'session required pam_permit.so' >> /etc/pam.d/su

# The /home/$TARGET_USER/.ssh folder was created with SOPs and is owned by root instead of the user
chown -R "$TARGET_USER": "/home/$TARGET_USER"
mkdir -m 1777 /tmp
export PATH=/sw/bin:$PATH

# Manually simulate $HM_GEN/activate as it doesn't work in containers
# su "$TARGET_USER" -c "export NIX_REMOTE=; $HM_GEN/activate"
HM_GEN=$(find /nix/store -maxdepth 2 -name activate | grep home-manager-generation | head -n 1 | xargs dirname)

if [ -z "$HM_GEN/home-files" ]; then
   echo "ERROR: Could not find Home Manager generation."
   exit 1
fi

echo 'Linking files from home-files...'
su "$TARGET_USER" -c "cp -rsf --no-preserve=mode,ownership $HM_GEN/home-files/. /home/${TARGET_USER}/"
su "$TARGET_USER" -c "ln -sfn \"$HM_GEN\" \"\$HOME/.nix-profile\""

export PATH="$HOME/.nix-profile/bin:/sw/bin:$PATH"
su - "$TARGET_USER" -s /sw/bin/zsh

