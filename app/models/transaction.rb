class Transaction # < ApplicationRecord
  attr_reader :payer, :points, :time_stamp

  # validates :payer, presence: true
  # validates :points, presence: true
  # validates :time_stamp, presence: true

  def initialize(data)
    @payer = data[:payer]
    @points = data[:points]
    @time_stamp = data[:time_stamp]
  end



end
