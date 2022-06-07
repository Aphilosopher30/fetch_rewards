class TransactionController < ApplicationController

  def create

    data = {payer: params[:payer], points: params[:points].to_i}
    begin
      data[:time_stamp] = Time.parse(params[:time_stamp])
    rescue ArgumentError
      data[:time_stamp] = Time.now
    end

    new_transaction = Transaction.new(data)

    render json: TransactionSerializer.new(new_transaction)
  end


end
