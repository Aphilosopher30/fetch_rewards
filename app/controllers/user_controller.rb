class UserController < ApplicationController

  def payers
    render json: Transaction.report
  end

end
