class Transaction # < ApplicationRecord
  attr_reader :payer, :points, :time_stamp

  # validates :payer, presence: true
  # validates :points, presence: true
  # validates :time_stamp, presence: true

  @@instances = []


  def initialize(data)
    @payer = data[:payer]
    @points = data[:points]
    @time_stamp = data[:time_stamp]
    @@instances << self
  end

  def self.all
    @@instances
  end

  def self.delte_all
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

end
