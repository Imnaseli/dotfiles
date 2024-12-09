# SSH Key Setup

This guide explains how to set up SSH keys for passwordless authentication and configure your SSH config file for easy access to remote computers.

## Prerequisites

- SSH client installed on your local machine
- Access to the remote computer you want to connect to

## Step 1: Generate SSH Key Pair

1. Open a terminal on your local machine.

2. Navigate to your SSH directory:
   `cd ~/.ssh`

3. Generate a new SSH key pair using the following command:
   `ssh-keygen -t rsa -b 4096 -f ~/.ssh/key_name`
   Replace `key_name` with a descriptive name for your key pair (e.g., `pathfinder_key`).

4. You will be prompted to enter a passphrase for the key. It's recommended to set a strong passphrase for enhanced security. However, if you prefer passwordless authentication, you can leave the passphrase empty by pressing `Enter` twice.

5. The SSH key pair will be generated and saved in the `~/.ssh` directory. The private key will be named `key_name`, and the public key will be named `key_name.pub`.

## Step 2: Copy Public Key to Remote Computer

1. Copy the public key to the remote computer using the following command:
   `ssh-copy-id -i ~/.ssh/key_name.pub port user@remote_host`
   Replace `key_name.pub` with the name of your public key file, `user` with the username on the remote computer, and `remote_host` with the IP address or hostname of the remote computer.

2. You will be prompted to enter the password for the user on the remote computer. After entering the password, the public key will be copied to the remote computer's `authorized_keys` file.

## Step 3: Configure SSH Config

1. Open the SSH config file in Vim:
   `vim ~/.ssh/config`

2. Press `i` to enter insert mode.

3. Add the following lines to the config file:

Host alias

HostName remote_host

User user

IdentityFile ~/.ssh/key_name

for example:

``` config

        Host pathfinder
            HostName 3232.2323.22.24
            User root
            IdentityFile ~/.ssh/id_rsa

```

Replace `alias` with a memorable alias for the remote computer (e.g., `pathfinder`), `remote_host` with the IP address or hostname of the remote computer, `user` with the username on the remote computer, and `key_name` with the name of your private key file.

4. Press `Esc` to exit insert mode.

5. Type `:wq` and press `Enter` to save the changes and exit Vim.

## Step 4: Connect to Remote Computer

You can now connect to the remote computer using the specified alias:
`ssh alias`
Replace `alias` with the alias you defined in the SSH config file.

SSH will use the settings defined in the config file, including the IP address, username, and SSH key, to authenticate and establish the connection.

## Security Considerations

- Keep your private key file (`key_name`) secure and never share it with anyone.
- Set appropriate file permissions for your SSH config and key files:
`chmod 600 ~/.ssh/config`
`chmod 600 ~/.ssh/key_name`
- If you set a passphrase for your key, make sure to choose a strong and memorable one.
- If you lose or compromise your private key, immediately remove the corresponding public key from the remote computer's `authorized_keys` file and generate a new SSH key pair.

By following these steps, you can securely set up SSH keys for passwordless authentication and easily connect to remote computers using aliases defined in your SSH config file.


# EXTRA CAUTION

Checking Your Server's SSH Configuration

Your server's sshd_config file might also play a role. Check for the following settings to ensure secure authentication:

    PermitRootLogin:
        Set to prohibit-password to allow root login only with keys and not with passwords:

        bash

    PermitRootLogin prohibit-password

PasswordAuthentication:

    Ensure this is set to no to disable password-based logins:

    bash

        PasswordAuthentication no

To apply these changes, edit your SSH configuration file (/etc/ssh/sshd_config) and restart the SSH service:

bash

sudo systemctl restart sshd
