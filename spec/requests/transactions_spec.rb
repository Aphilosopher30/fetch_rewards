require 'rails_helper'

RSpec.describe 'transactions request ', type: :request do

  describe "create a transaction" do
    describe "gives a proper response " do
      it 'creates a new transaction ' do

        prior_transactions = Transaction.all.count

        post '/user/transactions/new', params: {payer: "abbs Corp", points: 500, time_stamp: "2020-10-31T11:00:00Z"}

        expect(response).to be_successful
        expect(response.status).to eq(200)
        expect(response.content_type).to eq("application/json")

        transaction_data = JSON.parse(response.body, symbolize_names: true)


        expect(transaction_data[:data][:id]).to eq(nil)
        expect(transaction_data[:data][:type]).to eq("transaction")
        expect(transaction_data[:data][:attributes][:payer]).to eq("abbs Corp")
        expect(transaction_data[:data][:attributes][:points]).to eq(500)
        expect(transaction_data[:data][:attributes][:time_stamp]).to eq("2020-10-31T11:00:00.000Z")

        expect(Transaction.all.count).to eq(prior_transactions+1)
      end

      it 'can handle not being given a time_stamp' do
        prior_transactions = Transaction.all.count

        time = Time.now.round(3)
        allow(Time).to receive(:now).and_return(time)

        post '/user/transactions/new', params: {payer: "abbs Corp", points: 500}


        expect(response).to be_successful
        expect(response.status).to eq(200)
        expect(response.content_type).to eq("application/json")

        transaction_data = JSON.parse(response.body, symbolize_names: true)

        expect(transaction_data[:data][:id]).to eq(nil)
        expect(transaction_data[:data][:type]).to eq("transaction")
        expect(transaction_data[:data][:attributes][:payer]).to eq("abbs Corp")
        expect(transaction_data[:data][:attributes][:points]).to eq(500)
        expect(Time.parse(transaction_data[:data][:attributes][:time_stamp])).to eq(time)

        expect(Transaction.all.count).to eq(prior_transactions+1)
      end

      it 'can handle illegitimate time stamp' do
        prior_transactions = Transaction.all.count

        time = Time.now.round(3)
        allow(Time).to receive(:now).and_return(time)

        post '/user/transactions/new', params: {payer: "abbs Corp", points: 500, time_stamp: "afadsfdsaf"}


        expect(response).to be_successful
        expect(response.status).to eq(200)
        expect(response.content_type).to eq("application/json")

        transaction_data = JSON.parse(response.body, symbolize_names: true)

        expect(transaction_data[:data][:id]).to eq(nil)
        expect(transaction_data[:data][:type]).to eq("transaction")
        expect(transaction_data[:data][:attributes][:payer]).to eq("abbs Corp")
        expect(transaction_data[:data][:attributes][:points]).to eq(500)
        expect(Time.parse(transaction_data[:data][:attributes][:time_stamp])).to eq(time)

        expect(Transaction.all.count).to eq(prior_transactions+1)
      end
    end

    describe "sad paths" do


    end
  end


  describe "spends points" do
    it "it adds negative transactions" do
      Transaction.delete_all

      data0 = { payer: "DANNON", points: 1000, time_stamp: Time.parse("2020-11-02T14:00:00Z") }#5
      data1 = { payer: "UNILEVER", points: 200, time_stamp: Time.parse("2020-10-31T11:00:00Z") }#2
      data2 = { payer: "DANNON", points: -200, time_stamp: Time.parse("2020-10-31T15:00:00Z") }#3
      data3 = { payer: "MILLER COORS", points: 10000, time_stamp: Time.parse("2020-11-01T14:00:00Z") }#4
      data4 = { payer: "DANNON", points: 300, time_stamp: Time.parse("2020-10-31T10:00:00Z") }#1

      transaction0 = Transaction.new(data0)
      transaction1 = Transaction.new(data1)
      transaction2 = Transaction.new(data2)
      transaction3 = Transaction.new(data3)
      transaction4 = Transaction.new(data4)

      expect(Transaction.all.length).to eq(5)

      get '/user/transactions/spend', params: {points: 5000}

      expect(response).to be_successful
      expect(response.status).to eq(200)
      expect(response.content_type).to eq("application/json")

      transaction_data = JSON.parse(response.body, symbolize_names: true)

      expect(Transaction.all.length).to eq(8)
      expect(Transaction.all[-1].points < 0).to eq(true)
      expect(Transaction.all[-2].points < 0).to eq(true)
      expect(Transaction.all[-3].points < 0).to eq(true)

    end
    it "it returns proper response" do
      Transaction.delete_all

      data0 = { payer: "DANNON", points: 1000, time_stamp: Time.parse("2020-11-02T14:00:00Z") }#5
      data1 = { payer: "UNILEVER", points: 200, time_stamp: Time.parse("2020-10-31T11:00:00Z") }#2
      data2 = { payer: "DANNON", points: -200, time_stamp: Time.parse("2020-10-31T15:00:00Z") }#3
      data3 = { payer: "MILLER COORS", points: 10000, time_stamp: Time.parse("2020-11-01T14:00:00Z") }#4
      data4 = { payer: "DANNON", points: 300, time_stamp: Time.parse("2020-10-31T10:00:00Z") }#1

      transaction0 = Transaction.new(data0)
      transaction1 = Transaction.new(data1)
      transaction2 = Transaction.new(data2)
      transaction3 = Transaction.new(data3)
      transaction4 = Transaction.new(data4)

      expect(Transaction.all.length).to eq(5)

      get '/user/transactions/spend', params: {points: 5000}

      expect(response).to be_successful
      expect(response.status).to eq(200)
      expect(response.content_type).to eq("application/json")

      transaction_data = JSON.parse(response.body, symbolize_names: true)

# binding.pry

      expect(transaction_data.class).to eq(Array)
      expect(transaction_data.length).to eq(3)
      expect(transaction_data[0].class).to eq(Hash)
      expect(transaction_data[0][:points] < 0).to eq(true)
      expect(transaction_data[1][:points] < 0).to eq(true)
      expect(transaction_data[2][:points] < 0).to eq(true)

    end


  end


end
