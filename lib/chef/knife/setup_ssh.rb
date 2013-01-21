require_relative '../../core_ext'
require 'chef/knife'

class LisausaKnifePlugins::SetupSsh < ::Chef::Knife
  banner 'knife setup ssh (options)'

  deps do
    require 'chef/shef/ext'
  end

  option :write, long: '--write-file', boolean: true,
      description: 'Write the config to your ~/.ssh/config (CAREFUL!)'

  # This method will be executed when you run this knife command.
  def run
    Shef::Extensions.extend_context_object(self)
    ssh_config = []

    ssh_config << "### BEGIN KNIFE BLOCK ###"
    ssh_config << "## This was generated by `knife setup ssh`:"

    STDOUT.sync = true

    nodes.all do |n|
      next if /vagrant/.match(n.name)
      name = n.name
      name << '.lisausa.net' unless /\.lisausa.net\Z/.match(n.name)

      begin
        hostname = n.ipaddress
      rescue => ex
        ui.warn("Error (#{ex.inspect}) while getting #ipaddress for #{n.name}")
        next
      end

      ssh_config << [
        "Host #{name}",
        "  HostName #{hostname}",
        "  HostKeyAlias #{[name,hostname,n.macaddress].join('-')}"
      ]
    end

    if (c = Chef::Config.knife).keys.grep(/identity_file|ssh_user/).any?
      ssh_config.push [
        "Host *.lisausa.net",
        "  IdentitiesOnly yes",
        "  PasswordAuthentication no",
        "  ForwardAgent yes"
      ]
      ssh_config.push "  IdentityFile #{c[:identity_file]}" if c[:identity_file]
      ssh_config.push "  User #{c[:ssh_user]}" if c[:ssh_user]
    end

    ssh_config << "### END KNIFE BLOCK ###"
    ssh_config = ssh_config.flatten.join("\n")

    file_path = File.join(ENV['HOME'], '.ssh', 'config')
    if config[:write] or ui.ask_question("Write config to #{file_path} (Y/N)?", default: 'N').downcase == 'y'
      FileUtils.copy_file(file_path, "#{file_path}~")
      File.open(file_path, File::RDWR|File::CREAT) do |f|
        f.flock(File::LOCK_EX)

        contents = f.read.gsub(/### BEGIN KNIFE BLOCK ###.+?(### END KNIFE BLOCK ###|\Z)/m, ssh_config)
        unless contents.include?('### BEGIN KNIFE BLOCK ###')
          contents << ssh_config
        end
        f.rewind
        f.truncate(0)
        f.write contents
      end
      ui.msg "Wrote to #{file_path}. Previous contents were backed up to #{file_path}~"
    else
      ui.msg "Copy and paste the following into your #{file_path} file:"
      ui.msg ssh_config
    end
  end

end
