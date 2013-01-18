require 'fileutils'

module Puppet
  module Module
    class JavaProgram
      
      def self.all_programs
        base_directory = File.join(Rails.configuration.puppet_module_path, "java_program", "files", "opt")
        program_directories = Dir.glob(File.join(base_directory, "*"))
        program_directories.map { |program_directory| File.basename(program_directory) }
      end
      
      # Wow, this is totally insecure. But it will do.
      def self.save(program_name, temporary_artifact, uploaded_name)
        program_directory = File.join(Rails.configuration.puppet_module_path, "java_program", "files", "opt", program_name)
        program_artifact_path = File.join(program_directory, "#{program_name}#{File.extname(uploaded_name)}")
                
        FileUtils.rm_rf(program_directory)
        FileUtils.mkdir(program_directory)
        FileUtils.copy(temporary_artifact.path, program_artifact_path)
      end
    end
  end
end
