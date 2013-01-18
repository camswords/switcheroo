
class ProgramsController < ActionController::Base
  
  def start
    Puppet::Module::Agent.start_program(params[:program_name])
    flash[:notice] = "#{params[:program_name]} has been started."
    redirect_to "/running"
  end

  def stop
    Puppet::Module::Agent.stop_program(params[:program_name])
    flash[:notice] = "#{params[:program_name]} has been stopped."
    redirect_to "/running"
  end
  
  def new
    Puppet::Module::JavaProgram.save(params[:name], params[:artifact].tempfile, params[:artifact].original_filename)
    flash[:notice] = "#{params[:name]} has been uploaded."
    redirect_to "/available"
  end
  
  def delete
    Puppet::Module::JavaProgram.delete(params[:program_name])
    flash[:notice] = "#{params[:program_name]} has been deleted."
    redirect_to "/available"
  end

end