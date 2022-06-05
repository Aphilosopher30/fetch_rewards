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
end
