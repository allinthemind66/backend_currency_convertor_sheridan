class CurrencyController < ApplicationController
  @@currencies = {}
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
