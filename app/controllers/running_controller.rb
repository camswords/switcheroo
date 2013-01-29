class RunningController < ActionController::Base
  
  def show
    @all_programs = Puppet::Module::JavaProgram.all_programs
    @running_programs = Puppet::Module::Agent.running_programs
    @stopped_programs = @all_programs - @running_programs
  end
end