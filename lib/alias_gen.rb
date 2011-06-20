require 'yaml'

module SshKeyMan
  class AliasGen
    SERVER_LIST = File.join(".", "server_list.yml")

    def self.generate user
      servers = YAML::load_file(SERVER_LIST)['servers']
      puts "\e[31m You can copy below code to '~/.bash_profile' or '~/.bashrc'. \e[0m"
      puts "============================================="
      get_user_groups(user).each do |group|
        servers[group].each do |server|
          puts "alias #{group}_#{server['alias']}=\"#{server['user']}@#{server['host']}\""
        end
      end
      puts "============================================="
    end
    
    def self.get_user_groups user
      user_groups = `cd available_public_keys; find . -name #{user}`.split("\n")
      raise "Not found user: \"#{user}\"" if user_groups.size == 0
      user_groups.map { |user_group| user_group.slice(/[^\.\/]+(?=\/)/) }
    end
  end
end