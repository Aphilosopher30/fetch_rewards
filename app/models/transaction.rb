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
      subtraction_hash[transaction.payer] += transaction.points
    end

    return subtraction_hash
  end

  def self.all_positive
    @@instances.find_all do |transaction|
      transaction.points >= 0
    end
  end

  def self.sort_aquired_points_by_date
    self.all_positive.sort_by { |obj| obj.time_stamp.to_i }
  end
end
