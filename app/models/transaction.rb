class Transaction # < ApplicationRecord
  attr_reader :payer, :points, :time_stamp, :id

  # validates :payer, presence: true
  # validates :points, presence: true
  # validates :time_stamp, presence: true

  @@instances = []

  def initialize(data)
    @id = nil
    @payer = data[:payer]
    @points = data[:points]
    @time_stamp = data[:time_stamp]
    @@instances << self
  end

  def self.all
    @@instances
  end

  def self.delete_all
    @@instances = []
  end

  def self.all_subtractions
    @@instances.find_all do |transaction|
      transaction.points < 0
    end
  end

  def self.spent_hash
    subtraction_hash = Hash.new(0)

    self.all_subtractions.each do |transaction|
      # binding.pry
      subtraction_hash[transaction.payer] += transaction.points
    end

    return subtraction_hash
  end


  def self.sort_points_by_date
    @@instances.sort_by { |obj| obj.time_stamp }
  end

  # def spend
  #   selecct oldest from list.
  #   add to the list of all negatives
  #   and when the sum of the list of all negatives is equal to or exceeds the target spending
  #      then subtract target spending from the sum of all negatives
  #      take the result and subtract the result from from whatever payers list was last increased
  #
  # end


end
