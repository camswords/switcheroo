require 'puppet/module/java_program'

module Puppet
  module Module
    class Truth
      
      def self.update
        all_programs = Puppet::Module::JavaProgram.all_programs
        
        modules = all_programs.map do |program_name|
          MODULE_TEMPLATE.gsub("%__PROGRAM_NAME__%", program_name)
        end
        
        enforcer_path = File.join(Rails.configuration.puppet_module_path, "truth", "manifests", "enforcer.pp")
        File.open(enforcer_path, 'w') do |file|
          file.write(ENFORCER_TEMPLATE.gsub("%__MODULES__%", modules.join("\n")))
        end
      end
      
      ENFORCER_TEMPLATE = <<END_OF_TEMPLATE
        class truth::enforcer {

        	notice("$fqdn, I see that you're a: $server_tags")

        	include java
        	include puppet_agent
          
          %__MODULES__%
        }
END_OF_TEMPLATE

      MODULE_TEMPLATE = <<END_OF_TEMPLATE
      if has_role("%__PROGRAM_NAME__%") {
    		class { 'java_program': jar_file => "%__PROGRAM_NAME__%.jar", program_name => "%__PROGRAM_NAME__%" }	
    	} else {
    		class { 'java_program::remove': program_name => "%__PROGRAM_NAME__%" }
    	}
    	
END_OF_TEMPLATE

    end
  end
end