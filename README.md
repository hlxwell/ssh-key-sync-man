SSH Key sync tool Readme
========================

This tool is used to mass deploy ssh-keys to all your servers according to the config.


Usage
=====

1. `gem install ssh-key-sync-man`

2. Put all your team members' keys into one `available_public_keys` directory with the structure looks like:

        available_public_keys/groupA/michael
        available_public_keys/------/jason
        available_public_keys/------/john
        available_public_keys/groupB/rose
        available_public_keys/------/ryan

3. Add a `server_list.yml`, format like:

        servers:
          groupA:
            - host: xxx.com
              user: app
          groupB:
            - host: aaa.com
              user: app
              alias: app_server
            - host: aaa.com
              user: db
              alias: db_master

    (You can puts `available_public_keys` and `server_list.yml` at github, them people can add files by themselves)

4. ssh-key-sync-man -g groupA

  This will deploy public keys in `available_public_keys/groupA` to groupA servers


"alias" list -- linux shotcut command list auto generator
=========================================================

`ssh-key-sync-man -a michael` generate alias for michael.

Generate alias file for everyone, for example:

    alias serverA_app1="ssh app@host"
    alias serverB_app2="ssh app@host"
    alias serverC_db="ssh app@host"
    alias serverD_staging="ssh app@host"

You can copy and paste into your .bashrc or .bash_profile