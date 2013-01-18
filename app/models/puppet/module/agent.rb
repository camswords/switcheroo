
module Puppet
  module Module
      
    class Agent
  
      def self.running_programs
        server_tags_file = File.join(Rails.configuration.puppet_module_path, "puppet_agent/files/etc/puppet/server_tags")
        return [] unless File.exists?(server_tags_file)
        
        server_tags = IO.read(server_tags_file)
        server_tags.gsub(/\n|,/,"").split("role:").select { |role| role && !role.empty? }
      end
    end
  end
end