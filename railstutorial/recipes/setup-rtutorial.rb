rtutorial = search("aws_opsworks_app", "shortname:railstutorial").first

Chef::Log.info('Setting up railstutorial server')

execute "apt-get update and upgrade" do
  command "apt-get update && apt-get upgrade"
end

directory '/data/railstutorial' do
  recursive true
  action :delete
end

directory '/data/railstutorial' do
  recursive true
  action :create
end

template "/tmp/id_deploy" do
  variables( :sshkey => rtutorial["app_source"]["ssh_key"])
  mode 0600
  owner "root"
  group "root"
  source "sshkey.erb"
end

cookbook_file "/tmp/wrap-ssh4git.sh" do
  source "wrap-ssh4git.sh"
  owner "ubuntu"
  mode "0755"
end

git "/data/railstutorial" do
  repo rtutorial["app_source"]["url"]
  revision rtutorial["app_source"]["revision"]
  ssh_wrapper "/tmp/wrap-ssh4git.sh"
  action :sync
  user "root"
end

package 'nginx' do
  action :install
end
