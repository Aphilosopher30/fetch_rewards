class TransactionController < ApplicationController

  def create
# binding.pry
    data = {payer: params[:payer], points: params[:points].to_i, time_stamp: Time.parse(params[:time_stamp])}
    if data[:time_stamp].class != Time
      data[:time_stamp] = Time.now
    end

    new_transaction = Transaction.new(data)


# binding.pry

    render json: TransactionSerializer.new(new_transaction)

  end


end
