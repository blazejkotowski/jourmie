module DeviseHelper

  # Devise fucked helpers
  def resource_name
    :user
  end
 
  def resource
    @resource ||= User.new
  end
 
  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
  
  def resource_class
    devise_mapping.to
  end
  
  def resource_for(controller)
    if controller_name == controller.to_s
      resource
    else
      User.new
    end
  end
  
end
