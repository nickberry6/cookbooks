rtutorial = search("aws_opsworks_app", "shortname:railstutorial").first

Chef::Log.info('Setting up railstutorial server')

execute "apt-get update and upgrade" do
  command "apt-get update && apt-get upgrade"
end

git "/data/railstutorial" do
  repo rtutorial["app_source"]["url"]
  revision rtutorial["app_source"]["revision"]
  action :sync
end

package 'nginx' do
  action :install
end
