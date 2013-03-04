class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def all
    user = User.from_omniauth(request.env["omniauth.auth"])
    if user.persisted?
      flash.notice = "Successfully signed in."
      sign_in_and_redirect user
    else
      flash[:info] = "You must provide your e-mail address" if user.email.blank?
      session["devise.user_attributes"] = user.attributes.merge({ "profile" => user.profile })
      redirect_to new_user_registration_url
    end
  end
  
  alias_method :facebook, :all
  alias_method :twitter, :all
end
