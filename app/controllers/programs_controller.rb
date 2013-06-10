
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
    if !params[:name] || params[:name].blank? || !params[:artifact] || File.extname(params[:artifact].original_filename) != ".jar"
      flash[:error] = "Please provide a name and an artifact. The artifact has to be a jar file."
    else
      Puppet::Module::JavaProgram.save(params[:name], params[:artifact].tempfile, params[:artifact].original_filename)
      flash[:notice] = "#{params[:name]} has been uploaded."
    end    
      redirect_to "/available"
    end
  
  def delete
    Puppet::Module::Agent.stop_program(params[:program_name])
    if Puppet::Module::JavaProgram.delete(params[:program_name])
      flash[:notice] = "#{params[:program_name]} has been deleted."
    else
      flash[:error] = "failed to delete #{params[:program_name]}."
    end

    redirect_to "/available"
  end

end