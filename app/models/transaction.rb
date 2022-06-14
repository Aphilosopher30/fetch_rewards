class Transaction # < ApplicationRecord
  attr_reader :payer, :points, :timestamp, :id

  # validates :payer, presence: true
  # validates :points, presence: true
  # validates :timestamp, presence: true

  @@instances = []

  def initialize(data)
    @id = nil
    @payer = data[:payer]
    @points = data[:points]
    @timestamp = data[:timestamp]
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
    self.all_positive.sort_by { |obj| obj.timestamp.to_i }
  end

  def self.report
    ledger = Hash.new(0)
    self.all.each do |transaction|
      ledger[transaction.payer] += transaction.points
      # binding.pry
    end
    return ledger
  end
end
