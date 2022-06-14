class UserController < ApplicationController

  def payers
    # binding.pry
    render json: Transaction.report
  end

end
