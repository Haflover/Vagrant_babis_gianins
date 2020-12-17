Vagrant.configure("2") do |config|
 
config.vm.box = "hashicorp/bionic64"
config.vm.network  "public_network"
config.vm.provider "virtualbox" do |v|
    v.name = "MpampisGiannis"
    v.cpus  = 2
    v.memory = 2048
  end

config.vm.provision "shell", path: "scriptV11.sh"
end
