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

      Transaction.delete_all

      expect(Transaction.all).to eq([])

    end

    it '.all returns a list of every transaction' do

      Transaction.delete_all

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

    it '.all_subtractions returns all negative, and only negative transactions' do
      Transaction.delete_all

      time = Time.now
      data = {
              payer: "company co",
              points: -100,
              time_stamp: time
              }
      transaction = Transaction.new(data)

      time2 = Time.now
      data2 = {
              payer: "binsnss bizz",
              points: 500,
              time_stamp: time2
              }
      transaction2 = Transaction.new(data2)

      time3 = Time.now
      data3 = {
              payer: "binsnss bizz",
              points: -300,
              time_stamp: time3
              }
      transaction3 = Transaction.new(data3)

      expect(Transaction.all_subtractions.length).to eq(2)
      Transaction.all_subtractions.each do |trans|
        expect(trans.points <= 0).to eq(true )
      end
    end

    it '.spent_hash returns a hash, which contains the sum of all negative transactions per company' do
      Transaction.delete_all

      time = Time.now
      data = {
              payer: "company co",
              points: -100,
              time_stamp: time
              }

      transaction1 = Transaction.new(data)
      time1 = Time.now
      data1 = {
              payer: "company co",
              points: -150,
              time_stamp: time1
              }
      transaction1 = Transaction.new(data1)


      time2 = Time.now
      data2 = {
              payer: "binsnss bizz",
              points: 500,
              time_stamp: time2
              }
      transaction2 = Transaction.new(data2)

      time4 = Time.now
      data4 = {
              payer: "abC corp",
              points: -400,
              time_stamp: time4
              }
      transaction4 = Transaction.new(data4)

      time5 = Time.now
      data5 = {
              payer: "binsnss bizz",
              points: -300,
              time_stamp: time5
              }
      transaction5 = Transaction.new(data5)

      time6 = Time.now
      data6 = {
              payer: "Ink inc.",
              points: 600,
              time_stamp: time6
              }
      transaction6 = Transaction.new(data6)

      expect(Transaction.spent_hash.length).to eq(3)
# binding.pry
      expect(Transaction.spent_hash['company co']).to eq(-250)
      expect(Transaction.spent_hash['binsnss bizz']).to eq(-300)
      expect(Transaction.spent_hash["abC corp"]).to eq(-400)
      expect(Transaction.spent_hash["Ink inc."]).to eq(0)
    end

    it '.sort_points_by_date ' do
      Transaction.delete_all

      time = Time.parse("2020-07-31T11:00:00.000Z")
      data = {
              payer: "company co",
              points: -100,
              time_stamp: time
              }

      transaction = Transaction.new(data)

      time1 = Time.parse("2020-08-31T11:00:00.000Z")
      data1 = {
              payer: "company co",
              points: -150,
              time_stamp: time1
              }
      transaction1 = Transaction.new(data1)


      time2 = Time.parse("2020-03-31T11:00:00.000Z")
      data2 = {
              payer: "binsnss bizz",
              points: 500,
              time_stamp: time2
              }
      transaction2 = Transaction.new(data2)

      time4 = Time.parse("2020-01-31T11:00:00.000Z")
      data4 = {
              payer: "abC corp",
              points: -400,
              time_stamp: time4
              }
      transaction4 = Transaction.new(data4)

      time5 = Time.parse("2020-12-31T11:00:00.000Z")
      data5 = {
              payer: "binsnss bizz",
              points: -300,
              time_stamp: time5
              }
      transaction5 = Transaction.new(data5)

      time6 = Time.parse("2020-11-31T11:00:00.000Z")
      data6 = {
              payer: "Ink inc.",
              points: 600,
              time_stamp: time6
              }
      transaction6 = Transaction.new(data6)

      expect(Transaction.all[0].time_stamp).to eq(time)
      expect(Transaction.all[1].time_stamp).to eq(time1)
      expect(Transaction.all[2].time_stamp).to eq(time2)
      expect(Transaction.all[3].time_stamp).to eq(time4)
      expect(Transaction.all[4].time_stamp).to eq(time5)
      expect(Transaction.all[5].time_stamp).to eq(time6)


      expect(Transaction.sort_points_by_date[0].time_stamp).to eq(time4)
      expect(Transaction.sort_points_by_date[1].time_stamp).to eq(time2)
      expect(Transaction.sort_points_by_date[2].time_stamp).to eq(time)
      expect(Transaction.sort_points_by_date[3].time_stamp).to eq(time1)
      expect(Transaction.sort_points_by_date[4].time_stamp).to eq(time6)
      expect(Transaction.sort_points_by_date[5].time_stamp).to eq(time5)


    end

  end


end
