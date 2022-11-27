# :notes: Create a new CentOS 7 Virtual Machine in VirtualBox

By Antonio Salazar - September 2022

# :paw_prints: Steps

1. Download the `CentOS-7-x86_64-Minimal-2009.iso` from the [**CentOS downloads**](https://www.centos.org/download/) page.
2. On **VirtualBox** open the main menu and select the **Machine -> New...** option.
    
    ![centos7](images/centos7.png)
    
3. **Name and operating system**: Input the parameters below.
    1. **Name**: is the VM name.
    2. **Machine Folder**: the place where to save the VM configuration files, logs and disks.
    3. **Type**: select Linux as OS type.
    4. **Version**: select Red Hat (64-bit) option.
    
    ![centos7](images/centos7_1.png)
    
4. **Memory Size: s**et that to 2 GB.
    
    ![centos7](images/centos7_2.png)
    
5. **Hard disk**: Select the Create a virtual hard disk now option.
    
    ![centos7](images/centos7_3.png)
    
6. **Hard disk file type: s**elect the VDI (VirtualBox Disk Image) option.
    
    ![centos7](images/centos7_4.png)
    
7. **Storage on physical hard disk**: choose Dynamically allocated option.
    
    ![centos7](images/centos7_5.png)
    
8. **File location and size**: select the file location and 20 GB disk size. 
    
    ![centos7](images/centos7_6.png)
    
9. Once the VM is created, click on the **Properties** menu.
    
    ![centos7](images/centos7_7.png)
    
10. Open the **Storage** menu:
    1. Under Controller IDE click on the **Optical Drive**. 
    2. Pick the **CentOS-7-x86_64-Minimal-2009.iso** image file.
    3. Click **Ok**.
    
    ![centos7](images/centos7_8.png)
    
11. Open the Network menu and input the parameters below:
    1. **Enable Network Adapter**: checked.
    2. **Attached to**: Bridged Adapter.
    3. **Name**: your local PC or laptop network device name, either Wireless or Ethernet.
    4. Expand the **Advanced** option.
    5. **Cable Connected**: checked.
    6. Click **Ok**.
    
    ![centos7](images/centos7_9.png)
    
12. Click on the **Start** button.
    
    ![centos7](images/centos7_10.png)
    
13. When the VM launches, select the **Install CentOS 7** menu option.
    
    ![centos7](images/centos7_11.png)
    
14. **WELCOME TO CENTOS 7**: Select your preferred language and click **Continue**.
    
    ![centos7](images/centos7_12.png)
    
15. **INSTALLATION SUMMARY:** select the INSTALLATION DESTINATION option.
    
    ![centos7](images/centos7_13.png)
    
16. **INSTALLATION DESTINATION**: select Automatically configure partitioning and click on **Done**.
    
    ![centos7](images/centos7_14.png)
    
17. **NETWORK & HOSTNAME**: 
    1. **Ethernet (enp0s3)**: ON
    2. **Hostname**: input the name you would like to identify your VM host.
    3. **Done**.
    
    ![centos7](images/centos7_15.png)
    

15. **USER SETTINGS**: select the **ROOT PASSWORD:** menu.

![centos7](images/centos7_16.png)

1. ROOT PASSWORD: type the password for root and confirm.
    
    ![centos7](images/centos7_17.png)
    
2. CREATE USER: input the following parameters:
    1. **Full Name**: user’s full name.
    2. **User name**: host user account name.
    3. **Make this user administrator**: checked.
    4. **Require a password to user this account:** checked.
    5. **Done**.
    
    ![centos7](images/centos7_18.png)
    
3. The installation process starts, so wait until the number of packages are copied and installed.
    
    ![centos7](images/centos7_19.png)
    
4. Once the installation of CentOS 7 gets complete, click on the Reboot button. (due to the resolution of the VM, the Reboot button could be hidden or shows just a corner of it).
    
    ![centos7](images/centos7_20.png)
    
5. The process is done, the VM is started up and able to login with either the root or administrator accounts.
    
    ![centos7](images/centos7_21.png)