# -*- mode: ruby -*-
# vi: set ft=ruby :

def fail_with_message(msg)
  fail Vagrant::Errors::VagrantError.new, msg
end

def fail_without_plugin(plugin)
  if !Vagrant.has_plugin? plugin
    fail_with_message "${plugin} missing, please install the plugin with this command:\n" +
      "vagrant plugin install ${plugin}"
  end
end

ip = '192.168.70.70'

VAGRANTFILE_API_VERSION = "2"
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "ubuntu/focal64"
  # config.vm.box_url = "http://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box"
  config.vm.network :private_network, ip: ip

  fail_without_plugin 'vagrant-hostmanager'

  config.hostmanager.enabled = true
  config.hostmanager.manage_host = true
  config.hostmanager.aliases = [
    'suite.local',
  ]

  fail_without_plugin 'vagrant-env'

  fail_without_plugin 'vagrant-vbguest'

  # Dont try to reconcile guest addition versions
  config.vbguest.auto_update = false

  config.vm.synced_folder ".", "/vagrant"
  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", "2000"]
    vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    # Sync NTP every 10 seconds to avoid drift
    vb.customize ["guestproperty", "set", :id, "/VirtualBox/GuestAdd/VBoxService/--timesync-set-threshold", 10000]
  end

  config.vm.provision "shell", 
    path: "vagrant/change_mirror.sh", 
    env: { "LOCAL_MIRROR_SUBDOMAIN" => "au" }
  config.vm.provision "shell", path: "vagrant/vagrant.sh"
end
