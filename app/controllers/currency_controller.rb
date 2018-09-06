class CurrencyController < ApplicationController
  @@currencies = {}

  #FRONT END WILL CHECK TO SEE IF THERE IS A CURRENCY
  #WILL NEED TO ALSO SET A TIME OUT TO DELETE A CURRENCY AFTER 60 SECONDS
  #IF CURRENCY EXISTS, SEND IT TO FRONT END
  #IF IT DOESN'T EXIST, THEN ADD IT TO THE BACKEND

  def index
    render json: @@currencies
  end

  def create
    @@currencies[params.keys[0]] = params[params.keys[0]]['val']
    task = Concurrent::TimerTask.new do
       @@currencies[params.keys[0]] = nil
       puts "#{@@currencies[params.keys[0]]} entry has been deleted"
       task.shutdown
     end
    task.execute
    render json: @@currencies
  end
end
