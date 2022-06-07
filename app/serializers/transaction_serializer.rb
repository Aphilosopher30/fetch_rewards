class TransactionSerializer
  include FastJsonapi::ObjectSerializer
  set_type :transaction
  attributes :payer, :points, :time_stamp
end
