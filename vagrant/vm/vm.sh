#!/usr/bin/bash
# Name:         vm.sh
# Description:  create a vagrant virtual machine from the Vagrantfile definition.
# Usage:        vm.sh <Vagrantfile path and name>
# Log           Who                 What
# ================================================================================================================
# 2022.08.17    Antonio Salazar     Initial creation.
# 2023.02.01                        Enhanced getting the Vagrantfile location by argument.
# 2023-02-06                        Fixed context config files functionality.
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#
# Script version
#
version="2023.02.01";

usage() {
    echo "Usage: \n:";
    echo "vm.sh <Vagrantfile path and name>";
}

set_vagrantfile() {

    export VAGRANT_HOME="$HOME/vagrant"

    # create vm directory if not exist
    [ ! -d $VAGRANT_HOME/$project ] && mkdir -p $VAGRANT_HOME/$project ;
    [ `echo $?` -eq 0 ] && echo "The project $project was created successfully." ;

    # Copy the config files
    cp -p $project/* $VAGRANT_HOME/$project/ ;

    # validate the Vagrantfile exist
    if [ ! -f $VAGRANT_HOME/$project/Vagrantfile ]; then
        echo "The $VAGRANT_HOME/$project/Vagrantfile was not found.";
        exit 1;
    else    
        echo "Vagrant file found at `ls -l $VAGRANT_HOME/$project/Vagrantfile`" ;
    fi

    cd $VAGRANT_HOME/$project ;
}


create_vm(){
    vagrant init;
}

start_vm(){
    vagrant up;
}

stop_vm(){
    vagrant halt;
}

destroy_vm(){

    echo "here I am `pwd`"; 
    # remove SSH ports from $HOME/.ssh/known_hosts
    for port in `cat ssh_ports.cfg`; do
        ssh-keygen -f "$HOME/.ssh/known_hosts" -R "[127.0.0.1]:$port";
    done

    # remove vagrant files
    vagrant destroy -f;
    [ -d $VAGRANT_HOME/$project/.vagrant ] && rm -rf $VAGRANT_HOME/$project/.vagrant ;
    [ -f $VAGRANT_HOME/$project/Vagrantfile ] && rm -f $VAGRANT_HOME/$project/Vagrantfile;
}

#
# MAIN
#
[ "$#" -lt 1 ] && usage && exit 1;

# Vagrant file directory
export project="$1";

if [ ! -d $project ] ; then
    echo "The directory $project was not found";
    exit 1;
fi

# Set up the Vagrantfile working directory
set_vagrantfile ;

flag=1
while [ $flag -eq 1 ]
do
    PS3="Please select an option for the cluster: " ;
    select opt in "Create" "Start" "Stop" "Destroy" "Quit"
    do
        echo "You picked the ${REPLY} option: $opt" ;
        case "$opt" in
            "Create")  create_vm   ;;
            "Start")   start_vm    ;;
            "Stop")    stop_vm     ;;
            "Destroy") destroy_vm  ;;
            "Quit")    flag=0      ;;
            *) 
                echo "Unkown option"
            ;;
        esac ;
        break ;
    done ; 
done ;
