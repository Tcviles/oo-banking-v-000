require'pry'

class Transfer
  attr_accessor :sender, :receiver, :amount
  attr_reader :status

  def initialize (sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @amount = amount
    @status = 'pending'
  end

  def valid?
    sender.valid? && receiver.valid?
  end

  def execute_transaction
    #binding.pry
    if !@sender.valid? || @sender.balance < @amount
      @status = 'rejected'
      "Transaction rejected. Please check your account balance."
    elsif @status == "complete"
      "complete"
    else
      @sender.balance -= @amount
      @receiver.balance += @amount
      @status = 'complete'
    end
  end

  def reverse_transfer
    if @status == 'complete'
      @sender.balance += @amount
      @receiver.balance -= @amount
      @status = 'reversed'
    else
      "Reverse not available"
    end
  end
end
