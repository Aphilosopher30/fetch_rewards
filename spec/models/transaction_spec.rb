require 'rails_helper'

RSpec.describe Transaction do

  context 'the transaction class exists and has attributes' do
    it 'has atrributes' do

      time = Time.now
      data = {
              payer: "company co",
              points: 100,
              time_stamp: time
              }


      transaction = Transaction.new(data)

      expect(transaction.payer).to eq('company co')
      expect(transaction.points).to eq(100)
      expect(transaction.time_stamp).to eq(time)
    end
  end

  context 'class methods' do
    it '.delete_all removes every transaction' do

      time = Time.now
      data = {
              payer: "company co",
              points: 100,
              time_stamp: time
              }
      transaction = Transaction.new(data)

      time2 = Time.now
      data2 = {
              payer: "binsnss bizz",
              points: 300,
              time_stamp: time2
              }
      transaction2 = Transaction.new(data2)

      expect(Transaction.all.class).to_not eq([])

      Transaction.delte_all

      expect(Transaction.all).to eq([])

    end

    it '.all returns a list of every transaction' do

      Transaction.delte_all

      time = Time.now
      data = {
              payer: "company co",
              points: 100,
              time_stamp: time
              }

      transaction = Transaction.new(data)

      time2 = Time.now
      data2 = {
              payer: "binsnss bizz",
              points: 300,
              time_stamp: time2
              }

      transaction2 = Transaction.new(data2)

      expect(Transaction.all.class).to eq(Array)
      expect(Transaction.all.length).to eq(2)
    end
  end

end
