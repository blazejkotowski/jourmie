module ApplicationHelper
  def full_page_title(title="")
    if title.empty?
      "Jourmie"
    else
      "#{title} | Jourmie"
    end
  end
  
  def show_profile_path(user, attrs = {})
    url_for attrs.merge({:controller => "/user_profiles", :action => "show", :id => user.profile.permalink})
  end
  
  def show_profile_url(user, attrs = {})
    show_profile_path(user, attrs)
  end
end
