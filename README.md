# scripts

## Commands

### gc
Git clone and set local user.name and user.email
```shell
$ gc <git-uri>
```

## Deployment
* Clone repo to local
    ```shell
    $ cd /path/to/your/localtion
    $ git clone git@github.com:xpw-osr/scripts.git
    ```
    and add it to path
    ```shell
    export SCRIPTS_HOME=/path/to/scripts/repo/folder
    ```
* Add following code to your shell rc file
    ```shell
    alias gc=$SCRIPTS_HOME/git/gc.sh 
    ```
