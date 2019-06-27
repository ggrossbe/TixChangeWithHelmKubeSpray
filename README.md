# TixChangeWithHelmKubeSpray

./mainInstaller.sh

Deploy and setup TixChange on K8s.
 *********
1. Make sure HOST_IP field is updated in config.ini
2. Make sure ssh key is setup among all your nodes to connect from this box without passwd
3. Make sure you have 40G available in the install folder (/opt/ca/TixChangeK8sDemo) volume
4. Make sure you run this as root
 *********
Press y to proceed

y

Choose your option and press enter

Options:
 
 a : install all (K8s,Helm, UMA, TixChange, Selenium)
 
 p : run the pre-reqa
 
 u : install & run just uma
 
 t : install & run just tixChange
 
 s : install & run just selenium
 
 c : cleanup and unintsall everything


more info available at https://cawiki.ca.com/display/SASWAT/Tixchange+in+K8s+V2.0
