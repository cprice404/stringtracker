# stringtracker
An easy way to keep track of i18n externalization progress

## Git steps on setting up a git repo
This guide will tell you how to update your repo to the current and latest working state

1. Check your remote
  1. `git remote -v`
  2. There should be a remote in there that is a url to the Puppetlabs repos (your github username is **NOT** it)
    * Puppetlabs URL: `git@github.com:puppetlabs/puppetserver.git`
    * your personal URL: `git@github.com:jane/puppetserver.git`
    * See Note at bottom of this page for details on remotes.
  3. If you do not see a Puppetlabs url, then add it
    * `git remote add Puppetlabs [Puppetlabs URL]`
2. Pull from Puppetlabs URL
  1. `git fetch Puppetlabs (or whatever is the name of the Puppetlabs URL)`
  2. `git pull Puppetlabs master`
    * note that not all repos have a `master` branch, some are the version number (ex: `2016.3.x`), make sure to check on github.com
3. Change your local working state to the most up to date work state from the team
  * `git checkout Puppetlabs/master` 
  * or 
  * `git checkout [the name associated to your Puppetlabs URL]/[most current branch]`

**NOTE** 
Example output from `git remote -v`
```
origin	    https://github.com/janelu2/ezbake.git (fetch)
origin	    https://github.com/janelu2/ezbake.git (push)
Puppetlabs	https://github.com/puppetlabs/ezbake.git (fetch)
Puppetlabs	https://github.com/puppetlabs/ezbake.git (push)
```
`origin` is the name of a personal repo located at https://github.com/janelu2/ezbake

`Puppetlabs` is the name of the team repo located at https://github.com/puppetlabs/ezbake

These two are called "remotes"

When you don't specify `Puppetlabs` in your git commands, it will default to `origin`. 
It's safe to always specify the remote.
