# :notebook: Create an Oracle Linux 7 Cluster with Vagrant

By Antonio Salazar - August 2022

The project's goal is to create a three-node cluster as a playground. The cluster virtual machines are created automatically using Bash, Vagrant, and Virtual Box.

The cluster consists of a master node and two workers.

The virtual machines run Oracle Linux version 7, but they can be customizable to run any other operating system from the [vagrant boxes](https://app.vagrantup.com/boxes/search).

## Prerequisites:

- Install [Vritual Box](https://www.virtualbox.org/wiki/Documentation) on your system.

- Install [Vagrant](https://www.vagrantup.com/) on your system.
# :paw_prints: Steps

1. Choose the Vagrant [Box](https://app.vagrantup.com/boxes/search) to work with

    > _In this example the Box is based on Oracle Linux 7_

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


# :scroll: Scripts
- [cluster.sh](cluster.sh)
- [vagrant_boxes.json](vagrant_boxes.json)

# :books: References
- :link: [Vagrant](https://www.vagrantup.com/) 
- :link: [Vagrant boxes](https://app.vagrantup.com/boxes/search) 