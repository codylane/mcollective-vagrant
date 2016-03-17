# mcollective-vagrant
A vagrant machine that is capable of building a small mcollective environment for local testing.

# Pre-Setup
* Requires that you have vagrant installed and working with virtualbox
* This has only been tested on CentOS 6.x.

# Configuration
You will need to set the followin environment variables in order to use
this integration

* `VAGRANT_BOX`     => This should be the name of the box you want to use
* `VAGRANT_BOX_URL` => This should be the url that contains how to fetch
  the box.

## Using build.sh to simple your setup.
Inside of `.gitignore` is a reference that allows you define your own
personal build.sh script that will help save you time when invoking
`vagrant up` or `vagrant provision`.  You may choose to use this to
help save you keystorkes.

Here is an example usage of `build.sh'

```
cat > ./build.sh << BUILDSH_EOF
export VAGRANT_BOX=''
export VAGRANT_BOX_URL=''

vagrant $*

BUILDSH_EOF
chmod 755 ./build.sh
```

### build.sh usage

* This would fire up the middleware host for the first time
```
./build.sh up middleware
```

* This would provision the middleawre host
```
./build.sh provision middleware
```

* This would fire up all hosts defined in your `Vagrantfile`
```
./build.sh up
```

* This allows you to ssh to the middleware host
```
./build.sh ssh middleware
```
