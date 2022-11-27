#!/usr/bin/bash
# Name:         create_ol7_cluster.sh
# Description:  create an oracle linux 7 version with vagrant
# Usage:        create_ol7_cluster.sh
# Log           Who                 What
# ================================================================================================================
# 2022.08.17    Antonio Salazar     Initial creation.
# ================================================================================================================
#
# Script version
#
version="2022.08.17";


set_env() {
    # set working directory and cluster VM names
    export home=~/vagrant ;
}

set_vagrantfile() {

    # Virtual OS box version & URL
    export box_osv="$1"; 
    export box_url="$2";
    export box_project="`echo $box_osv | cut -f 1 -d \/`";
    export workdir=${home}/${box_project};

    # create vm directory tree
    [ ! -d $workdir ] && mkdir -p  $workdir ;
    echo "Workdir created at $workdir" ;

    # Create Vagrant file    
    [ -f ${workdir}/Vagrantfile ] && rm -f ${workdir}/Vagrantfile || [ ! -f ${workdir}/Vagrantfile ] && touch ${workdir}/Vagrantfile ;
    echo "Vagrant file found at `ls -l ${workdir}/Vagrantfile`" ;

    cat > ${workdir}/Vagrantfile <<EOF
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
EOF
}

create_cluster(){
    vagrant init ${workdir}/Vagrantfile ;
}

start_cluster(){
    cd ${workdir} && vagrant up;
}

stop_cluster(){
    cd ${workdir} && vagrant halt;
}

destroy_cluster(){
    cd ${workdir} && vagrant destroy -f;
}

#
# MAIN
#
set_env;
set_vagrantfile "oraclelinux/7" "http://oracle.github.io/vagrant-projects/boxes/oraclelinux/7.json" ;
#create_cluster;
#start_cluster;

PS3="Please select an option for the cluster: " ;
select opt in "Create" "Start" "Stop" "Destroy" "Quit";
do
  echo "You picked the ${REPLY} option: $opt" ;
  message="";
  case "$opt" in
      "Create")  create_cluster ;;
      "Start")   start_cluster ;;
      "Stop")    stop_cluster ;;
      "Destroy") destroy_cluster ;;
      "Quit")  break ;;
      *)
        echo "Unkown option";
        break 
      ;;
  esac ;
done ;
