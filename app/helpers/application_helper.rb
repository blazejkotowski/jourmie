module ApplicationHelper
  def full_page_title(title="")
    if title.empty?
      "Jourmie"
    else
      "#{title} | Jourmie"
    end
  end
  
  def show_profile_path(user)
    url_for :controller => "/user_profiles", :action => "show", :id => user.profile.permalink
  end
  
  def show_profile_url(user)
    show_profile_path(user)
  end
end
