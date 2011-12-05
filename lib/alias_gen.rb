require 'yaml'

module SshKeyMan
  class AliasGen
    def self.generate user
      server_list_path = File.join(".", "server_list.yml")
      servers = YAML::load_file(server_list_path)#['servers']
      groups = get_user_groups(user,servers)

      puts "\e[31m You can copy below code to '~/.bash_profile' or '~/.bashrc'. \e[0m"
      puts "============================================="
      groups.each do |group|
        servers[group]["servers"].each do | server |
          puts "alias #{group}_#{server['alias']}=\"#{server['user']}@#{server['host']}\""
        end
      end
      puts "============================================="
    end

    def self.get_user_groups(user,servers)
      user_groups = []
      servers.each do |gkey,values|
        if values.has_key?("users") and values.fetch("users").include?(user)
          user_groups.push(gkey)
        end
      end

      raise "Not found user: \"#{user}\"" if user_groups.size == 0
      return user_groups
    end
  end
end
