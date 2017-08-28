# qwik-hosts
Qwik-hosts manages your `/etc/hosts` file so that it doesn't get too unwieldy. Different projects, networks or tasks sometimes require different host file entries to properly resolve domain names. After a while trying to maintain my host file by hand I got fed up and decided it would be much better managed by a program. I first tried to run a local DNS using `dnsmasq` but I found the documentation lacking. More importantly, it is missing the ability to mix and match modular host-file entries, which is
essential to managing multiple projects. Qwik-hosts is a simple solution - a way to easily rewrite your hosts file in a predictable and qwik manner.

Qwik-hosts is written and tested on OS X but it should work on any Unix-like OS that uses an `/etc/hosts` file.

## Getting Started
Clone this repository and install the executable script (`qwik`) somewhere on your PATH.

```
$ git clone git@github.com:RichardSchmitz/qwik-hosts.git
$ ln -s $(pwd)/qwik-hosts/qwik ~/bin/qwik
```

(this assumes `~/bin` is already on your PATH). Using a symlink instead of copying the executable directly means you can pull further updates from the git repo simply using `git pull`.

You need to initialize the `qwik` environment before its first use. Run:

```
$ qwik init
Creating qwik directory tree and installing _default host file...
```

Now the environment is ready to go. You should see one host file is already enabled:

```
$ qwik list
_default.........................(enabled): Default Mac OS X hosts - do not disable!
```

You should not disable or remove this host file as it is required by OS X during the boot process. Note that if you are not on OS X you will have to replace this default host file with the default host file from your OS. Do this using `qwik edit _default`.

Now you can take your kludged-together host file and split it up into manageable pieces. Use `qwik add <host-file>` to add a new host file. Then run `qwik edit <host-file>` and paste in a section from your old file. Alternatively, use `qwik link <host-file-path>` to link to an existing partial hostfile. To enable it, run `qwik enable <host-file>`.

One last thing: all we've done so far is define new host files. We haven't actually rewritten the master file at `/etc/hosts` yet. To do this, run `qwik refresh` (you may want to save a backup first, until you're satisfied that things are working as expected).

For more information on any commands, run `qwik help`.

## Details
Qwik-hosts combines multiple `/etc/hosts`-like files into a single `/etc/hosts`. The same rules apply to these modular files as to the regular /etc/hosts file - namely, one DNS entry per line, and comments begin with a #. Modular host files live under your user's home directory so they are protected and customizable per user (on the off chance that you're sharing a machine with another dev).

Qwik-hosts is modeled after Apache's virtual hosts. There are multiple host files defined in hosts-available and those that are enabled are symlinked in hosts-enabled. You can link/unlink/modify these by hand without any adverse effects but it is much easier to manage them using `qwik`'s built-in commands.

## Customization
Each time a `qwik` command is run, `~/.qwikrc` is first sourced (if it exists). This allows you to set any environment variables you may want to customize. One in particular that you may customize is the location of the hosts-available and hosts-enabled directories (called DIR_QWIK). By default they are placed in `~/.qwik/` but they can be moved anywhere you like.

## Exit codes
Just in case you're using `qwik` as part of a script, it may be helpful to know what the different exit codes mean.

* `0` - The command completed successfully
* `1` - Your environment is not set up properly to run `qwik`. Define any environment variables listed in the output.
* `2` - Bad usage. Check the output message and/or help documentation to figure out why your command was incorrect.

## Development
### Running Tests
Tests follow the [roundup](http://bmizerany.github.io/roundup/) shell unit testing framework. Install roundup using `brew install roundup`. Run all tests using `roundup test/*`, or run a specific test using `roundup test/refresh-test.sh`. *Important:* These tests must be run from within the root directory of the repository.

### Todo
Qwik-hosts works well as-is, but there is always room in a project for improvement. I have the following features in mind for future development:

* Auto-refresh host file after disabling/removing a modular file
* Implement qwik mv and qwik cp
* Add note to hosts file saying what modules were included and add status line to qwik list showing whether these match the currently enabled host modules
* Add env variable that overrides _default hosts file content (to support other OSes)
* Add qwik lock/unlock <file>... command that chowns/chmods the files to prevent tampering without sudo (also use env variables to override the user/group that file gets set to)
* Figure out a better way for tests to get env variables then from the *actual* `~/.qwikrc`
