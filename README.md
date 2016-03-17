# mcollective-vagrant
A vagrant machine that is capable of building a small mcollective environment for local testing.

# Pre-Setup
* Requires that you have vagrant installed and working with virtualbox
* This has only been tested on CentOS 6.x.

# What does this do?
## On the middleware host
* This contains (activemq + mcollective) that allows your nodes to
  connect too.

## On a node
* This contains (activemq) + the mco command so that you can run things
  like `mco ping`, `mco find` etc.

## How do I customize the number of nodes?
* Update your Vagrant file and specify the number of instances in the
  `INSTANCE` variable.  This defaults to 5 nodes with `384MB` of RAM.

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

Here is an example usage of `build.sh`

```
cat > ./build.sh << BUILDSH_EOF
export VAGRANT_BOX='centos-65-x64-vbox436-nocm'
export VAGRANT_BOX_URL='http://puppet-vagrant-boxes.puppetlabs.com/centos-65-x64-virtualbox-nocm.box'

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

## How to ssh to a particulare node
* This allows you to ssh to the middleware host
```
vagrant ssh middleware
```

* This allows you to ssh to node0
```
vagrant ssh node0
```
