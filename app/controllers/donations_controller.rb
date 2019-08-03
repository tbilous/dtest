class DonationsController < ApplicationController
  respond_to :json

  def graph
    respond_with @donations = Donation.group_by_date
  end
end
