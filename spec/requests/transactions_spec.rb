require 'rails_helper'

RSpec.describe 'transactions request ', type: :request do

  describe "create a transaction" do

    describe "gives a proper response " do
      it 'creates a new transaction ' do

        post '/user/transactions/new', params: {payer: "abbs Corp", points: 500, time_stamp: "2020-10-31T11:00:00Z"}

        expect(response).to be_successful
        expect(response.status).to eq(200)
        expect(response.content_type).to eq("application/json")

        picture_data = JSON.parse(response.body, symbolize_names: true)

        expect(picture_data[:data][:id]).to eq(nil)
        expect(picture_data[:data][:type]).to eq("transaction")
        expect(picture_data[:data][:attributes][:payer]).to eq("abbs Corp")
        expect(picture_data[:data][:attributes][:points]).to eq(500)
        expect(picture_data[:data][:attributes][:time_stamp]).to eq("2020-10-31T11:00:00.000Z")
      end


    end

    describe "sad paths" do


    end


  end

end
