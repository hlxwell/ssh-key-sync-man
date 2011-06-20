require 'rubygems'
require 'net/scp'
require 'yaml'

module SshKeyMan
  class Uploader
    SERVER_LIST      = File.join(".", "server_list.yml")
    AUTHORIZED_KEYS  = File.join(".", "authorized_keys")

    # upload authorized_keys for a specific group
    #
    def self.upload_all_public_keys group
      upload_to_all_servers AUTHORIZED_KEYS, "~/.ssh/", group
    end

    # upload file to a group of servers
    #
    def self.upload_to_all_servers source, dest, group
      servers = YAML::load_file(SERVER_LIST)['servers'][group]
      raise "No Server Group: #{group}" if servers.size == 0
      servers.each do |server_info|
        upload! server_info["host"], server_info["user"], source, dest
      end
    end

    # upload a file to a remote server
    #
    def self.upload! host, user, source, dest
      puts "coping file from #{source} to #{user}@#{host}:#{dest}"
      `scp #{source} #{user}@#{host}:#{dest}`
      raise "upload failed" if $?.exitstatus != 0
    end
  end
end