GIMME COMPUTER
==============

Shell scripts to use virsh and diskimage-builder to create and destroy virtual
machines locally.

Examples
--------

Build an opensuse-minimal image::

  gimme image opensuse-minimal

By default, images are stored in ~/.gimme-images. Customize the output file name::

  gimme image opensuse-minimal -o myimage.qcow2

Use custom elements::

  ELEMENTS=caasp-base ELEMENTS_PATH=~/sles-elements gimme image sles-minimal

Run an instance::

  gimme vm myinstance opensuse-minimal

Get the IP address of a running instance::

  gimme ip myinstance

SSH into a running instance (uses your default id_rsa.pub or password 'devuser')::

  gimme ssh myinstance

Copy a file onto a running instance::

  scp /tmp/test-file.txt devuser@$(gimme ip myinstance):/remote/path

Destroy the instance::

  gimme clean myinstance

Destroy the instance and also remove the disk (does not remove the original
image)::

  gimme clean myinstance -f
