# :notes: Create a new Ubuntu VM with Vagrant

By Antonio Salazar - December 2022

The project's goal is to create a new virtual machine as a playground. The virtual machine is created automatically using Vagrant and Virtual Box.

## Prerequisites:

- Install [Vritual Box](https://www.virtualbox.org/wiki/Documentation) on your system.

- Install [Vagrant](https://www.vagrantup.com/) on your system.
# :paw_prints: Steps

1. Choose the Vagrant [Box](https://app.vagrantup.com/boxes/search) to work with

    > _In this example the Box is based on Ubuntu 22.04 (jammy)_

2. Download the Bash script [cluster.sh](cluster.sh)

    _You may review the [vagrant_boxes.json](vagrant_boxes.json) file for other boxes._

3. Customize the `set_vagrantfile` function arguments in case you need a different box version.
i.e.

    ```bash
    set_vagrantfile "oraclelinux/7" "http://oracle.github.io/vagrant-projects/boxes/oraclelinux/7.json" ;
    ```

4. Execute the script

    ```bash
    ./cluster.sh
    ```

5. Select the option you need:
   
   1. **Create** a new cluster.

        This option creates three new virtual machines in Virtual Box, a master VM and two worker nodes. These VMs run Oracle Linux 7 in this example.

        Having the cluster created, just start or stop it when needed.

   2. **Start** an existing cluster.

        When the cluster is created the virtual machines are not running, so this instruction starts up the cluster virtual machines.

   3. **Stop** the cluster.

        This option stops the cluster virtual machines.

   4. **Destroy** the existing cluster.

        The Destroy option removes the cluster virtual machines.

   5. **Quit** to exit menu.

# Configuration file

The **Vagrant* file serves as the main configuration file. In there it is possible to set up the Virtual Machine configuration such as, the VM name, IP address, Memory, CPU and so on.

- **Variables**:
    - `box_osv` stores the vagrant box name.
    - `box_url` has the reference URL with the JSON configuration settings of the vagrant box.

- **Vagrantfile** example:

    ```bash
    # Vagrant configuration file for the entire cluster
    Vagrant.configure("2") do |config|

        # Controller or orchestrator VM  
        config.vm.define "controller" do |controller|
            controller.vm.box = "$box_osv"
            controller.vm.box_url = "$box_url"
            controller.vm.hostname = "vm-controller"
            controller.ssh.forward_agent = true
            controller.ssh.keep_alive = true
            controller.vm.network "private_network", ip: "192.168.56.5"
            controller.vm.network "forwarded_port", guest: 22, host: 2205, host_ip: "127.0.0.1"
            controller.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"
            controller.vm.provider "virtualbox" do |v|
            v.memory = 1024
            v.cpus   = 2
            v.name   = "vm-controller"
            v.customize ["modifyvm", :id, "--groups", "/vagrant_cluster"]
            end 
        end

        # Node1
        config.vm.define "worker1" do |worker1|
            worker1.vm.box = "$box_osv"
            worker1.vm.box_url = "$box_url"
            worker1.vm.hostname = "vm-worker-1"
            worker1.ssh.forward_agent = true
            worker1.ssh.keep_alive = true
            worker1.vm.network "private_network", ip: "192.168.56.6"
            worker1.vm.network "forwarded_port", guest: 22, host: 2206, host_ip: "127.0.0.1"
            worker1.vm.network "forwarded_port", guest: 80, host: 8086, host_ip: "127.0.0.1"
                worker1.vm.provider "virtualbox" do |v|
                v.memory = 512
                v.cpus   = 1
                v.name = "vm-worker-1"
                v.customize ["modifyvm", :id, "--groups", "/vagrant_cluster"]
            end
        end

        # Node2
        config.vm.define "worker2" do |worker2|
            worker2.vm.box = "$box_osv"
            worker2.vm.box_url = "$box_url"
            worker2.vm.hostname = "vm-worker-2"
            worker2.ssh.forward_agent = true
            worker2.ssh.keep_alive = true
            worker2.vm.network "private_network", ip: "192.168.56.7"
            worker2.vm.network "forwarded_port", guest: 22, host: 2207, host_ip: "127.0.0.1"
            worker2.vm.network "forwarded_port", guest: 80, host: 8087, host_ip: "127.0.0.1"
            worker2.vm.provider "virtualbox" do |v|
                v.memory = 512
                v.cpus   = 1
                v.name = "vm-worker-2"
                v.customize ["modifyvm", :id, "--groups", "/vagrant_cluster"]
            end
        end
    end 
    ```

# :scroll: Scripts
- [cluster.sh](cluster.sh)
- [vagrant_boxes.json](vagrant_boxes.json)

# :books: References
- :link: [Vagrant](https://www.vagrantup.com/) 
- :link: [Vagrant boxes](https://app.vagrantup.com/boxes/search) 