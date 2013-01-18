
class ProgramsController < ActionController::Base
  
  def start
    Puppet::Module::Agent.start_program(params[:program_name])
    flash[:notice] = "Program #{params[:program_name]} has been started."
    redirect_to "/running"
  end

  def stop
    Puppet::Module::Agent.stop_program(params[:program_name])
    flash[:notice] = "Program #{params[:program_name]} has been stopped."
    redirect_to "/running"
  end

end