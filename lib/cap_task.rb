require "file_combiner"
Capistrano::Configuration.instance(true).load do
  namespace :ssh_key_sync_man do
    desc "Sync keys to servers"
    task :sync do
      SshKeyMan::PublicKeyCombiner.combine_developer_public_keys
      puts "Deploying authorized_keys ..."
      put "tmp/authorized_keys", File.join("/home/#{user}", ".ssh", "authorized_keys")
    end
  end
end