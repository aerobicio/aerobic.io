class MembersController < ApplicationController
  def index
    render file: "#{Rails.root}/public/404.html",  status: :not_found
  end
end
