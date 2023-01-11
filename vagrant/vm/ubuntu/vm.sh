#!/usr/bin/bash
# Name:         vm.sh
# Description:  create new ubuntu 22.04 VM with vagrant
# Usage:        vm.sh
# Log           Who                 What
# ================================================================================================================
# 2022.12.18    Antonio Salazar     Initial creation.
# ================================================================================================================
#
# Script version
#
version="2022.12.18";


set_env() {
    # set working directory and VM name
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

    # VM build 
    config.vm.define "build" do |build|
        build.vm.box = "$box_osv"
        build.vm.box_url = "$box_url"
        build.vm.hostname = "ubuntu-2204"
        build.ssh.forward_agent = true
        build.ssh.keep_alive = true
        build.vm.network "private_network", ip: "192.168.56.70"
        build.vm.network "forwarded_port", guest: 22, host: 2270, host_ip: "127.0.0.1"
        build.vm.provider "virtualbox" do |v|
            v.memory = 1024
            v.cpus   = 2
            v.name   = "ubuntu-2204"
            v.customize ["modifyvm", :id, "--groups", "/vagrant_vm"]
        end 
    end
end    
EOF
}

create_vm(){
    vagrant init ${workdir}/Vagrantfile ;
}

start_vm(){
    cd ${workdir} && vagrant up;
}

stop_vm(){
    cd ${workdir} && vagrant halt;
}

destroy_vm(){
    rm -f Vagrantfile ;
    rm -f .vagrant ;
    cd ${workdir} && vagrant destroy -f;
    rm -f ${workdir}/Vagrantfile ;
    rm -f ${workdir}/.vagrant ;
}

#
# MAIN
#
set_env;
set_vagrantfile "ubuntu/jammy64" "https://app.vagrantup.com/ubuntu/boxes/jammy64/versions/20220810.0.0/providers/virtualbox.box" ;

flag=1
while [ $flag -eq 1 ]
do
    PS3="Please select an option for the VM: " ;
    select opt in "Create" "Start" "Stop" "Destroy" "Quit";
    do
        echo "You picked the ${REPLY} option: $opt" ;
        case "$opt" in
            "Create")  create_vm   ;;
            "Start")   start_vm    ;;
            "Stop")    stop_vm     ;;
            "Destroy") destroy_vm  ;;
            "Quit")    flag=0      ;;
            *) echo "Unkown option";;
        esac ;
        break ;
    done ; 
done ;
