require 'rails_helper'

RSpec.describe Transaction do

  context 'the transaction class exists and has attributes' do
    it 'has atrributes' do

      time0 = Time.now
      data = {
              payer: "company co",
              points: 100,
              timestamp: time0
              }


      transaction = Transaction.new(data)

      expect(transaction.payer).to eq('company co')
      expect(transaction.points).to eq(100)
      expect(transaction.timestamp).to eq(time0)
    end
  end

  context 'class methods' do
    it '.delete_all removes every transaction' do

      time = Time.now
      data = {
              payer: "company co",
              points: 100,
              timestamp: time
              }
      transaction = Transaction.new(data)

      time2 = Time.now
      data2 = {
              payer: "binsnss bizz",
              points: 300,
              timestamp: time2
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
              timestamp: time
              }

      transaction = Transaction.new(data)

      time2 = Time.now
      data2 = {
              payer: "binsnss bizz",
              points: 300,
              timestamp: time2
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
              timestamp: time
              }
      transaction = Transaction.new(data)

      time2 = Time.now
      data2 = {
              payer: "binsnss bizz",
              points: 500,
              timestamp: time2
              }
      transaction2 = Transaction.new(data2)

      time3 = Time.now
      data3 = {
              payer: "binsnss bizz",
              points: -300,
              timestamp: time3
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
              timestamp: time
              }

      transaction1 = Transaction.new(data)
      time1 = Time.now
      data1 = {
              payer: "company co",
              points: -150,
              timestamp: time1
              }
      transaction1 = Transaction.new(data1)


      time2 = Time.now
      data2 = {
              payer: "binsnss bizz",
              points: 500,
              timestamp: time2
              }
      transaction2 = Transaction.new(data2)

      time4 = Time.now
      data4 = {
              payer: "abC corp",
              points: -400,
              timestamp: time4
              }
      transaction4 = Transaction.new(data4)

      time5 = Time.now
      data5 = {
              payer: "binsnss bizz",
              points: -300,
              timestamp: time5
              }
      transaction5 = Transaction.new(data5)

      time6 = Time.now
      data6 = {
              payer: "Ink inc.",
              points: 600,
              timestamp: time6
              }
      transaction6 = Transaction.new(data6)

      expect(Transaction.spent_hash.length).to eq(3)
# binding.pry
      expect(Transaction.spent_hash['company co']).to eq(-250)
      expect(Transaction.spent_hash['binsnss bizz']).to eq(-300)
      expect(Transaction.spent_hash["abC corp"]).to eq(-400)
      expect(Transaction.spent_hash["Ink inc."]).to eq(0)
    end

    it '.sort_aquired_points_by_date ' do
      Transaction.delete_all

      time0 = Time.parse("2020-07-31T11:00:00.000Z")
      data0 = {
              payer: "company co",
              points: 100,
              timestamp: time0
              }

      transaction = Transaction.new(data0)

      time1 = Time.parse("2020-08-31T11:00:00.000Z")
      data1 = {
              payer: "company co",
              points: 150,
              timestamp: time1
              }
      transaction1 = Transaction.new(data1)


      time2 = Time.parse("2020-03-31T11:00:00.000Z")
      data2 = {
              payer: "binsnss bizz",
              points: 500,
              timestamp: time2
              }
      transaction2 = Transaction.new(data2)

      time4 = Time.parse("2020-01-31T11:00:00.000Z")
      data4 = {
              payer: "abC corp",
              points: 400,
              timestamp: time4
              }
      transaction4 = Transaction.new(data4)

      time5 = Time.parse("2020-12-31T11:00:00.000Z")
      data5 = {
              payer: "binsnss bizz",
              points: 300,
              timestamp: time5
              }
      transaction5 = Transaction.new(data5)

      time6 = Time.parse("2020-11-31T11:00:00.000Z")
      data6 = {
              payer: "Ink inc.",
              points: 600,
              timestamp: time6
              }
      transaction6 = Transaction.new(data6)

      expect(Transaction.all[0].timestamp).to eq(time0)
      expect(Transaction.all[1].timestamp).to eq(time1)
      expect(Transaction.all[2].timestamp).to eq(time2)
      expect(Transaction.all[3].timestamp).to eq(time4)
      expect(Transaction.all[4].timestamp).to eq(time5)
      expect(Transaction.all[5].timestamp).to eq(time6)

      expect(Transaction.sort_aquired_points_by_date[0].timestamp).to eq(time4)
      expect(Transaction.sort_aquired_points_by_date[1].timestamp).to eq(time2)
      expect(Transaction.sort_aquired_points_by_date[2].timestamp).to eq(time0)
      expect(Transaction.sort_aquired_points_by_date[3].timestamp).to eq(time1)
      expect(Transaction.sort_aquired_points_by_date[4].timestamp).to eq(time6)
      expect(Transaction.sort_aquired_points_by_date[5].timestamp).to eq(time5)
    end

    it '.report ' do
      Transaction.delete_all

      time0 = Time.parse("2020-07-31T11:00:00.000Z")
      data0 = {
              payer: "company co",
              points: 100,
              timestamp: time0
              }

      transaction0 = Transaction.new(data0)

      time1 = Time.parse("2020-08-31T11:00:00.000Z")
      data1 = {
              payer: "company co",
              points: 150,
              timestamp: time1
              }
      transaction1 = Transaction.new(data1)


      time2 = Time.parse("2020-03-31T11:00:00.000Z")
      data2 = {
              payer: "binsnss bizz",
              points: 500,
              timestamp: time2
              }
      transaction2 = Transaction.new(data2)

      time3 = Time.parse("2020-01-31T11:00:00.000Z")
      data3 = {
              payer: "abC corp",
              points: 400,
              timestamp: time3
              }
      transaction3 = Transaction.new(data3)

      time4 = Time.parse("2020-01-30T11:00:00.000Z")
      data4 = {
              payer: "abC corp",
              points: -180,
              timestamp: time4
              }
      transaction4 = Transaction.new(data4)

      time5 = Time.parse("2020-12-31T11:00:00.000Z")
      data5 = {
              payer: "binsnss bizz",
              points: -300,
              timestamp: time5
              }
      transaction5 = Transaction.new(data5)

      time6 = Time.parse("2020-11-31T11:00:00.000Z")
      data6 = {
              payer: "Ink inc.",
              points: 600,
              timestamp: time6
              }
      transaction6 = Transaction.new(data6)

      expect(Transaction.report['abC corp']).to eq(220)
      expect(Transaction.report["Ink inc."]).to eq(600)
      expect(Transaction.report["binsnss bizz"]).to eq(200)
      expect(Transaction.report["company co"]).to eq(250)

    end



  end


end
