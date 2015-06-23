# D16 Deployment
This process will provision and install everything you need to develop for D16.

Prerequisites:
- [VirtualBox](https://www.virtualbox.org/wiki/Downloads) - Free virtual machine manager
- [Vagrant](https://www.vagrantup.com/downloads.html) - The software that provisions the VM

Installation:

1. Clone this repository
2. `$ cd <path to repository>`
3. Run the following code: 
```bash
vagrant up && bash install.sh
```

To re-install the virtual machine and grab a fresh version of the codebase (which you can do at any point!), run the following command:
```bash
vagrant destroy -f && vagrant up && bash install.sh
```