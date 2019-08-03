class HomeController < ApplicationController

  def show
    @users = User.all.includes(:donations)
  end
end
