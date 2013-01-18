
module Puppet
  module Module
      
    class Agent
  
      def self.running_programs
        server_tags_file = File.join(Rails.configuration.puppet_module_path, "puppet_agent/files/etc/puppet/server_tags")
        return [] unless File.exists?(server_tags_file)
        
        server_tags = IO.read(server_tags_file)
        server_tags.gsub(/\n|,/,"").split("role:").select { |role| role && !role.empty? }
      end
      
      def self.start_program(program_name)
        update_server_tags_with_programs(running_programs << program_name)
      end

      def self.stop_program(program_name)
        update_server_tags_with_programs(running_programs - [program_name])
      end
      
      def self.update_server_tags_with_programs(programs)
        server_tags_file = File.join(Rails.configuration.puppet_module_path, "puppet_agent/files/etc/puppet/server_tags")
        
        File.open(server_tags_file, 'w') do |file| 
          file.write(programs.map { |program_name| "role:#{program_name}"}.join(","))
        end
      end
    end
  end
end