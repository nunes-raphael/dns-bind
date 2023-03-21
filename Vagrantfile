$retransfer=<<-EOF
for i in $(sudo -E grep "zone" /etc/named/named.conf.local | grep -v arpa | awk '{print $2}' | sed 's/\"//g'); do sudo rndc retransfer $i;done
EOF

machines = {
  "dns-master" => {"memory" => "2048", "cpu" => "4", "ip" => "202", "image" => "generic/centos7", "name" => "dns-master"},
  "dns-slave-1" => {"memory" => "2048", "cpu" => "4", "ip" => "203", "image" => "generic/centos7", "name" => "dns-slave-1"},
  "dns-slave-2" => {"memory" => "2048", "cpu" => "4", "ip" => "204", "image" => "generic/centos7", "name" => "dns-slave-2"},
  "dns-slave-3" => {"memory" => "2048", "cpu" => "4", "ip" => "205", "image" => "generic/centos7", "name" => "dns-slave-3"},
}

Vagrant.configure("2") do |config|
  machines.each do |name, conf|
    config.vm.define "#{name}" do |machine|
      machine.vm.box = "#{conf["image"]}"
      machine.vbguest.auto_update = false
    	machine.vbguest.installer_options = { allow_kernel_upgrade: true }
      machine.vm.hostname = "#{name}"
      machine.vm.network "public_network", bridge: "enp3s0", ip: "192.168.0.#{conf["ip"]}"
      machine.vm.network "private_network", ip: "192.168.56.#{conf["ip"]}"
      machine.vm.synced_folder ".", "/vagrant", type: "nfs", nfs_version: 4
      machine.vm.provision "shell", path: "script.sh"      
      machine.vm.provider "virtualbox" do |vb|
        vb.name = "#{name}"
        vb.memory = conf["memory"]
        vb.cpus = conf["cpu"]
        vb.customize ["modifyvm", :id, "--groups", "/DNS-BIND"]
      end
      if "#{conf["name"]}" == "dns-master"
        machine.vm.provision "shell", path: "./dns-master/bind-config.sh", :privileged => true      
        machine.vm.provision "shell", :run => 'once', path: "./dns-master/dnssec.sh", :privileged => true        
      elsif "#{conf["name"]}" == "dns-slave-1"        
        machine.vm.provision "shell", :run => 'once', path: "./dns-slave-1/dns-slave-config.sh"
        machine.vm.provision "shell", inline: $retransfer        
      elsif "#{conf["name"]}" == "dns-slave-2"        
        machine.vm.provision "shell", :run => 'once', path: "./dns-slave-2/dns-slave-config.sh"
        machine.vm.provision "shell", inline: $retransfer        
      elsif "#{conf["name"]}" == "dns-slave-3"        
        machine.vm.provision "shell", :run => 'once', path: "./dns-slave-3/dns-slave-config.sh"
        machine.vm.provision "shell", inline: $retransfer        
      end
    end
  end
end