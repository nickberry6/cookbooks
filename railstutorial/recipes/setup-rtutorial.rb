Chef::Log.info('Setting up railstutorial server')

execute "apt-get update and upgrade" do
  command "apt-get update && apt-get upgrade"
end

bash 'Add ruby/rails' do
  user 'root'
  cwd '/tmp'
  code <<-EOH
      curl -sSL https://get.rvm.io | bash -s stable --ruby
    EOH
end

package 'nginx' do
  action :install
end
