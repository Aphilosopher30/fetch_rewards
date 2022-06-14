require 'rails_helper'

RSpec.describe 'user request ', type: :request do

  describe "get all payers" do
    it "returns payer ballances" do
      Transaction.delete_all

      data0 = { payer: "DANNON", points: 1000, timestamp: Time.parse("2020-11-02T14:00:00Z") }#5
      data1 = { payer: "UNILEVER", points: 200, timestamp: Time.parse("2020-10-31T11:00:00Z") }#2
      data2 = { payer: "DANNON", points: -200, timestamp: Time.parse("2020-10-31T15:00:00Z") }#3
      data3 = { payer: "MILLER COORS", points: 10000, timestamp: Time.parse("2020-11-01T14:00:00Z") }#4
      data4 = { payer: "DANNON", points: 300, timestamp: Time.parse("2020-10-31T10:00:00Z") }#1

      transaction0 = Transaction.new(data0)
      transaction1 = Transaction.new(data1)
      transaction2 = Transaction.new(data2)
      transaction3 = Transaction.new(data3)
      transaction4 = Transaction.new(data4)

      get '/user/payers'

      expect(response).to be_successful
      expect(response.status).to eq(200)
      expect(response.content_type).to eq("application/json")

      transaction_data = JSON.parse(response.body, symbolize_names: true)

      expect(transaction_data[:DANNON]).to eq(1100)
      expect(transaction_data[:"MILLER COORS"]).to eq(10000)
      expect(transaction_data[:UNILEVER]).to eq(200)
    end
  end
end
