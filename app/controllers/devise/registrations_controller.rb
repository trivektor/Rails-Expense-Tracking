class Devise::RegistrationsController < DeviseController
  
  # Copied from http://stackoverflow.com/questions/8666871/ruby-on-rails-user-registration-using-rest-api-call-and-devise
  def create
    respond_to do |format|
      
      format.html { super }
      
      format.json do
        build_resource
        
        if resource.save
          render :json => {:success => 1, :message => 'You have signed up successfully'}
        else
          Rails.logger.info 
          render :json => {:success => -1, :errors => resource.errors.full_messages.join(', ')}
        end
      end
      
    end
  end
  
end
