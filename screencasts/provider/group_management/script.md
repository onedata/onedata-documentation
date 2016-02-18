# Screencast: Installation of Onedata Provider on GCE

> **Summary**  
> This screencast presents installation of Oneprovider on Google Cloud Computing Engine.  
> Updated: 03.12.2015; Oneprovider Version: 2.7.1; Release: 1.el7.centos


## Preperation
1. Create new google user.
2. Configure google developer account with credit card.
3. Create onedata-something project.
4. Set Chrome browser to use previously created user as 'the browser user'
5. Have a small (~10-50MB) ex. mp3 file prepared for upload.
    1. Place that file in an empty folder.
    2. Upload to whatever web storage (ex. google drive). so that OSX filemanager remembered the empt folder as a default path it will open later.

## Some Cheating
1. Install wget in VM as a first step. Clear screen, so it looks like we start form the beginning.
2. We need to add a file /etc/ssl/cert.pem to Oneprovider. Execute:
~~~bash
sudo curl -o /etc/ssl/cert.pem https://s3-eu-west-1.amazonaws.com/uploads-eu.hipchat.com/132633/960218/7Mj2mbFmVHLFSeu/ca-bundle.crt

~~~

## Outline
> Numbered points guide the video art of the screencast.  
> The code blocks provide a script for every step.

1. Welcome screen
    1. Title slide
    ```
    The content of the slide:
      Title: Onedata
      Subtitle: Installation of Onedata Provider.

    Hello everyone, this is Michal from Onedata team.
    Today I will show you how to perform a single-vm installation of Onedata Provider on
    Google Compute Engine, with the operating system of choice beeign Centos 7.
    ```
    2. Navigate to next slide: Screecast outline overview
    ```
    The content of the slide:
      1. VM Setup on Google Compute Engine.
      2. Installation of Onedata Provider.
      3. Registration in Onedata Global Registry.
      4. Upload files via web Onedata Provider web interface

    During this short video, we will :
    - setup a virtual machine on the Google Compute Engine.
    - install onedata provider
    - register it in Onedata Global Registry
    - and upload a test file via Provider web interface
    ```
2. Create VM on Google Compute Engine
    1. Navigate to Google Developer Console
    ```
    For the purpose of this vide. I have created a google account that will be necessary
    to setup a virtual machine using Google Developer Console and to Login into Onedata Global Registry.

    In order to use google Compute Engine one has to fill in billing information and add the source of payment like VISA credit card. Fortunately at this time google offers new users a trial period of 60 days with 300 dolars to spend.

    I have already create a project called 'onedata'
    ```
    2. Navigate to onedata project in Google Developer Console
    3. Navigate Google Compute Engine
    ```
    We navigate to Google Compute Engine
    ```
    4. Navigate to VM Instances
    ```
    and to VM instances.
    ```
    4. Create VM
        ```
        We create a virtual machine.
        ```
        1. Set a name: onedataprovider1
        ```
        Lets call it onedataprovider1
        ```
        2. Pick a n1-stanadrd-2 instance type
        ```
        we pick a n1 stadanrd machine with 2 virtual CPU-s.
        ```
        3. Change OS to Centos 7
        ```
        change the operatine system to Centos 7.
        ```
        4. Allow for HTTP, HTTPS trafics.
        ```
        and allw for HTTP and HTTPS, as it is required by Onedata Provider web interface.
        ```
        5. Click create.
        ```
        And that's all.
        ```        
        5. Show that vm has been created on the Activities list.
3. Login into VM via. Google SSH Web Console
~~~
Now that the VM has been created, we can login into it, via google SSH Web Console.
~~~
4. Install Oneprovider
    1. Head to onedata.org
    ~~~
    Meanwhile we head to onedata.org
    ~~~
    7. Head to Download section,
    ~~~
    the the download section
    ~~~
    8. Navigate to instructions about installation of OneProvider. Copy first script line.
    ~~~
    and look for instruction on how to install onedata provider on centos 7
    ~~~
    9. Switch to Google SSH Web Console
    10. Perform Cheat 1.
    11. Perform Cheat 2.
    1. Downlad Globus Toolkit Repository. Navigate back to Chrome. Copy next script line.
    ~~~
    First we download the Globus Toolkit Repository
    ~~~
    2. Install Globus Toolkit Repository and EPL. Navigate back to Chrome. Copy next script line.
    ~~~
    and install it along with EPL repository.
    ~~~
    3. Install Onedata Repository for Centos 7. Navigate back to Chrome. Copy next script line.
    ~~~
    next we install the centos 7 specific onedata repository repository.
    ~~~
    4. Install OneProvider package.
    ~~~
    and at last, we install the oneprovider package, it has quite a few dependencies so it might take a while.

    Perfect.
    Now that oneprovider package has been installed we will use it to install core onedata components on this virtual machine. For that, we will use oneprovider web interface.
    ~~~
4. State that we need to open a port for OneProvider to work.
~~~
But first we need to open a port for oneprovider web interface.
~~~
5. Navigate to Google Developer Console Networking section
    ~~~
    We navigate to Networking section
    ~~~
    1. Pick a default network
    ~~~
    pick a default network
    ~~~
    2. Add a firewall rule
    ~~~
    and add a firewall rule
    ~~~    
    3. Name it OneProvider
    ~~~
    lets name it oneprovider
    ~~~  
    4. Set source filter for any source.
    ~~~
    set source filter for any incoming connections
    ~~~  
    4. Enter tpc:9444 port
    ~~~
    we are want to open the TCP port 9-4-4-3. But as we are already here, we will also open ports that will be needed in the later stage of installation. Those are, TCP port 53, TCP port 5-5-5-5 and TCP port 8-4-4-3.
    ~~~  
    5. Click: Create firewall rull.
    ~~~
    <say nothing, just click create>
    ~~~
6. Navigate to Onedata Project Home on Google Developer Console
 ~~~
 In order to access the oneprovider web interface
 ~~~
7. Show the public ip address
~~~
we need to find out what is the public ip address of the virtual machine.
~~~
8. Navigate to OneProvider address
    ~~~
    we enter it together with the port
    ~~~
    1. Trust not private connection
    ~~~
    <Ignore it, remain silent>
    ~~~
    2. (Cheat 2. needed)
    3. Enter username: admin, password: password. Click Log in.
    ~~~
    Default credentials are, user admin and password password
    ~~~
    4. With the mouse show all 3 kinds of nodes. Click next.
    ~~~
    As it is a single node installation we want to install all onedata components on this node.
    ~~~
    5. Allow for the node to serve as CCM. Click next.
    ~~~
    Similarly we allow this node to serve as a Central Cluster Manager component
    ~~~
    6. Hover the mouse over the ports.
    ~~~
    Here we have the full list of ports that need to be open for oneprovider to function properly.
    We opened HTTP and HTTPS ports during VM creation and the rest was added to the firewall rule.
    ~~~
    7. Click Next.
    8. Hover the mouse over numbers. Click Next.
    ~~~
    We agree for those file and processes limits.
    ~~~
    9. Hover over the input field.
    ~~~
    Now we have to select the directory on the virtual macine where oneprivder will store all the data.
    ~~~
    10. Navigate to Google SSH Web Console
    ~~~
    we head to Google SSH Web Console
    ~~~
    11. Execute ```sudo mkdir /onedata```
    ~~~
    and create the directory onedata directory
    ~~~
    12. Go back to Chrome, to onepanel installation
    ~~~
    and create the directory onedata directory
    ~~~
    13. Paste ```/onedata``` into the textfield. Click the plus on the right. Click next.
    ~~~
    Here we an see the summary of the distribution of oneprovider components over the nodes. What will be installed where.
    ~~~
    14. Hover mouse over progress bar, watch the installation until 96% (after that video can be cut)
    ~~~
    We proceed with the installation. As we can see the installation is going quite swiftly.
    Perfect. We have succesfully installed the oneprovider on the virtual machine.
    ~~~
9. Register oneprovider in Onedata Global Registy
    ~~~
    Now we need to register it in the Onedata Global Registry.
    ~~~
    1. Click Register.
    2. Step 1, Connection check.
        ~~~
        Oneprovider will try to check if it can connect to Onedata Global Registry.
        ~~~
        1. Hover over the text.
        2. Click Next.
    3. Step 2, Port Configuration.
        ~~~
        Oneprovider will try to check if it can connect to Onedata Global Registry.
        Fortunatelly we opened those ports before.
        Also we should double check if ip address that will be used for registation
        is a proper public ip address. From the address bar we see that it is.
        ~~~
        1. Hover mouse over the ports check.
        2. Select/highlight ip address.
        6. Click Next.
    4. Step 3, Registration Summary
        ~~~
        Lastly we have to pick a public name for our provider. Lets call it onedataprovidertest1
        ~~~
        1. Input text ex. 'onedataprovidertest1'
        2. Click Register.
    5. Registration Successful
        ~~~
        Perfect. The Registration was suffcesful.
        ~~~
        1. Hover over the provider ID.
        2. Click ok.
    6. Account settings.
        ~~~
        We were registered using those configuration parameters.
        ~~~
        1. Hover mouse over the configuration summary.
10. Registration was successful. Hurray!
11. Uploading files via OneProvider Web GUI.
    ~~~
    Now that we have succesfuly setup the onedata provider, lets see if we can upload some files.
    ~~~
    1. Navigate to onedata.org, to LOG IN
    ~~~
    First we have to login into Onedata Global Registry
    ~~~
    2. Sign in with google account.
    ~~~
    Using the test google account
    ~~~
    3. Hover over bottom text, that stays that our account has not space assigned.
    ~~~
    At the bottom we see the information that we have no storage space assigned to our account.
    However, fortunately for us we just finished seting up our own onedata provider.
    Lets use it to support our space.
    ~~~
    4. Hover over the token. Highlight it and copy it.
    ~~~
    In order to do that, we need this token.
    Normally we would send it to a provider with a request for storage space.
    But this time we can use it ourselfs.
    ~~~
    5. Navigate with Chrome to oneprovider Web interface.
    ~~~
    We head back to onedata provider web interface.
    ~~~
    6. With top menu, navigate to Spaces->Managment.
    ~~~
    Navigate to Spaces, Managment
    ~~~
    7. Click Support Space.
    ~~~
    We choose option to support a space.
    ~~~
    8. Paste the token.
    ~~~
    Paste the token
    ~~~
    9. Insert numerical value ex. 2 into space size field. Change the unit to GB.
    ~~~
    And decide, how much storage we want to assign. Lets try with 2 gigabytes.
    ~~~
    10. Navigate  in Chrome, back, to Onedata Global Registry
    ~~~
    We go back to Global Registry web interface.
    As we can see, now that our space is supported we can go and see our files.
    ~~~
    11. Click 'Go to your files
    ~~~
    Now actually, Global Registry direct us to the only Onedata Provider which supports our space.
    So in principle we go back Onedata Provider we creatd.
    The default space is empty. Lets upload a file.
    ~~~
    12. Click upload icon (second form the left [totally unintitive])
    ~~~
    <say nothing>
    ~~~
    13. Click Select files.
    ~~~
    I will pick something small - round 25 megabytes.
    ~~~
    14. Hover over the progress bar as it progresses.
    13. Click Select files.
    ~~~
    and now the file is beeign uploaded form my local pc to the provider located in the google cloud.
    Onedata actually does not impose any serious overheads, so the upload speend you see is only limited by my local connection to google.
    ~~~
    15. Hover over the file in oneprovider filemanager as it has been succesfully uploaded.
    ~~~
    The file has been succesfully upload. Lets see if we can actually download it. yep its downloading.
    ~~~
12. Go back to the screen with screencast outline and read/sumerise it.
~~~
Ok. So thank you for watching. In this short video we have seen how to:
- setup a vm on google compute engine,  
- how to install onedata provider
- how to register it in Onedata Global Registry
- and how upload the file to user account, using the the resources of provider we have installed.
~~~

# Script

We have succesfully installed the oneprovider on the virtual machine.
czy
We have succesfully installed the oneprovider components on the virtual machine.


Hello everyone this is Michal from one data team.
Today I will show you how install one client.
How to connect one client with your one data provider.
And how to upload files via one client.

In order to do that we I will use a provider that we created in a previous screencast.
I’ve already created a clean machine with a vanilla Centos 7.
