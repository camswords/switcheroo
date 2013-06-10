require 'fileutils'
require 'puppet/module/truth'

module Puppet
  module Module
    class JavaProgram
      
      def self.all_programs
        base_directory = File.join(Rails.configuration.puppet_module_path, "java_program", "files", "opt")
        program_directories = Dir.glob(File.join(base_directory, "*"))
        program_directories.map { |program_directory| File.basename(program_directory) }
      end
      
      def self.save(program_name, temporary_artifact, uploaded_name)
        program_directory = File.join(Rails.configuration.puppet_module_path, "java_program", "files", "opt", program_name)
        program_artifact_path = File.join(program_directory, "#{program_name}#{File.extname(uploaded_name)}")
                
        FileUtils.rm_rf(program_directory)
        FileUtils.mkdir_p(program_directory)
        FileUtils.chown('switcheroo', 'puppet', program_directory)

        # why does the ruby file utils not work on my ubuntu vm?
        `chmod 755 #{program_directory}`

        FileUtils.copy(temporary_artifact.path, program_artifact_path)
        FileUtils.chown('switcheroo', 'puppet', program_artifact_path)

        # why does the ruby file utils not work on my ubuntu vm?
        `chmod 644 #{program_artifact_path}`

        Puppet::Module::Truth.update
      end
      
      def self.delete(program_name)
        program_directory = File.join(Rails.configuration.puppet_module_path, "java_program", "files", "opt", program_name)
        FileUtils.rm_rf(program_directory)

        !File.exists? program_directory
      end
    end
  end
end
