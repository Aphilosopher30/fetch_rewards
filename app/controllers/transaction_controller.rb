class TransactionController < ApplicationController

  def create
# binding.pry
    data = {payer: params[:payer], points: params[:points].to_i, time_stamp: Time.parse(params[:time_stamp])}
    if data[:time_stamp].class != Time
      data[:time_stamp] = Time.now
    end

    Transaction.new(data)


# binding.pry


  # convert transaction from model-object to json using serializer

# new_user = User.create(email: params[:email].downcase, password: params[:password], password_confirmation: params[:password_confirmation])
# new_user.generate_api_key
# user_with_api_key = User.find_by(email: params[:email].downcase)
  # render json: UserSerializer.new(user_with_api_key)

  end


end
