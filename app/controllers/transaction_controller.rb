class TransactionController < ApplicationController

  def create
    data = {payer: params[:payer], points: params[:points].to_i}
    begin
      data[:time_stamp] = Time.parse(params[:time_stamp])
    rescue ArgumentError, TypeError
      data[:time_stamp] = Time.now
    end

    new_transaction = Transaction.new(data)

    render json: TransactionSerializer.new(new_transaction)
  end


  def spend

    cost = params[:points].to_i
    spent_points = Transaction.spent_hash

    Transaction.sort_aquired_points_by_date.each do |transaction|
      # binding.pry
      spent_points[transaction.payer] += transaction.points

      total_spent = check_total_money_spent(spent_points)

      if total_spent > cost
        over_shot = total_spent - cost
        spent_points[transaction.payer] -= over_shot
        break
      end
    end

    total_spent = check_total_money_spent(spent_points)


    if total_spent == cost
      who_pays = []
      spent_points.each do |payer, point_value|
        if point_value > 0
          data = {payer: payer, points: point_value*-1, time_stamp: Time.now}
          new_transaction = Transaction.new(data)
          who_pays << new_transaction
        end
      end
      render json: who_pays, :status => 200
    elsif total_spent < cost
      render json: {error: "insufficent funds"}, :status => 400
    elsif total_spent > cost
      render json: {error: "something's wrong, you are over spending"}, :status => 400
    else
      render json: {error: "this message ought be impossible to get"}, :status => 400
    end
  end


  def check_total_money_spent(hash)
    total = 0
    hash.each do |key, value|
      if value > 0
        total += value
      end
    end
    return total
  end


end
