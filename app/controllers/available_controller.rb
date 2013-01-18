require "puppet/module/java_program"
require "puppet/module/agent"

class AvailableController < ActionController::Base
  
  def show
    @all_programs = Puppet::Module::JavaProgram.all_programs
  end
end