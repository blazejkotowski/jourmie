class StaticPagesController < ApplicationController
  def home
    if signed_in?
      redirect_to albums_url
    end
  end
end
