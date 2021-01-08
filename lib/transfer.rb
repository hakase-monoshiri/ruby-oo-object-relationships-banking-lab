require 'pry'

class Transfer

  attr_reader :sender, :receiver, :amount
  attr_accessor :status

  @@completed_transfers = []

  def self.completed_transfers
    @@completed_transfers
  end

  
  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @amount = amount
    @status = "pending"
  end

  def valid?
    sender.valid? && receiver.valid?
  end

  def execute_transaction
    if valid? && sender.balance >= amount && self.status == "pending"
      sender.balance -=  amount
      receiver.deposit(amount)
      self.status = "complete"
      @@completed_transfers << self
    else
      self.status = "rejected"
      "Transaction rejected. Please check your account balance."
    end
  end

  def reverse_transfer
    if self.status == "complete"
      sender.deposit(amount)
      receiver.balance -= amount
      self.status = "reversed"
    end
  end

end
