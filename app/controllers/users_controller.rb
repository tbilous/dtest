class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @donations = current_user.donations
  end
end
