require 'rails_helper'

RSpec.describe 'transactions request ', type: :request do

  describe "create a transaction" do

    describe "gives a proper response " do
      it 'creates a new transaction ' do

        post '/user/transactions/new', params: {payer: "abbs Corp", points: 500, time_stamp: "2020-10-31T11:00:00Z"}


        # binding.pry

        # expect(response).to be_successful
        # expect(response.status).to eq(200)
        # expect(response.content_type).to eq("application/json")

        # user = JSON.parse(response.body, symbolize_names: true)

        # binding.pry
      end


    end

    describe "sad paths" do


    end


  end

end
