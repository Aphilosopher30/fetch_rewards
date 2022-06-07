require 'rails_helper'

RSpec.describe 'transactions request ', type: :request do

  describe "create a transaction" do
    describe "gives a proper response " do
      it 'creates a new transaction ' do

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
      end
    end

    describe "sad paths" do
      describe "gives a proper response " do
        it 'creates a new transaction ' do

          time = Time.new
          allow(Time).to receive(:now).and_return(time)

          post '/user/transactions/new', params: {payer: "abbs Corp", points: 500, time_stamp: "asdfasdf"}


          expect(response).to be_successful
          expect(response.status).to eq(200)
          expect(response.content_type).to eq("application/json")

          transaction_data = JSON.parse(response.body, symbolize_names: true)

          expect(transaction_data[:data][:id]).to eq(nil)
          expect(transaction_data[:data][:type]).to eq("transaction")
          expect(transaction_data[:data][:attributes][:payer]).to eq("abbs Corp")
          expect(transaction_data[:data][:attributes][:points]).to eq(500)
          expect(Time.parse(transaction_data[:data][:attributes][:time_stamp])).to eq(time.round(3))
        end
      end
    end


  end

end
