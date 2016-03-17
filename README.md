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
