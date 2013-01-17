
module Puppet
  module Module
    class JavaProgram
      
      def self.all_programs
        base_directory = File.join(Rails.configuration.puppet_module_path, "java_program/files/opt")
        program_directories = Dir.glob(File.join(base_directory, "*"))
        program_directories.map { |program_directory| File.basename(program_directory) }
      end
    end
  end
end
