RSpec.describe Credomatic::Payments do
  it "has a version number" do
    expect(Credomatic::Payments::VERSION).not_to be nil
  end

  it "initializes a transaction with a key id" do
    transaction = Credomatic::Payments::Transactions.new(123, 23232332222222222222222222222222)
    expect(transaction.key_id).to  eq(123)
  end

  it "generates a correct input hash" do
    transaction = Credomatic::Payments::Transactions.new(123, 23232332222222222222222222222222)

    orderid = "test"
    amount = 1.00
    time = 1279302634

    expect(transaction.input_hash(orderid, amount, time)).to  eq("416ed27036d4276a267818c530527acf")
  end

  it "generates a correct response hash" do
    transaction = Credomatic::Payments::Transactions.new(123, 23232332222222222222222222222222)

    orderid = "test" 
    amount= 1.00 
    response=1
    transactionid = 273247169 
    avsresponse="N" 
    cvvresponse="N"
    time = 1279302634

    expect(transaction.response_hash(orderid, amount, response, transactionid, avsresponse, cvvresponse, time)).to  eq("2f4f1c087cfd908903647823064da9bc")
  end

  it "generates a sale but declined by system" do
    transaction = Credomatic::Payments::Transactions.new(123, 23232332222222222222222222222222)
    response = transaction.generate_transaction("sale", nil, "4012001011000771", 1022, 1.00, "", 4223, "Desamparados", "")
    expect(response["response_code"]).to eq("200")
  end

end
