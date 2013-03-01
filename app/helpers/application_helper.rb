module ApplicationHelper
  def full_page_title(title="")
    if title.empty?
      "Jourmie"
    else
      "#{title} | Jourmie"
    end
  end
end
