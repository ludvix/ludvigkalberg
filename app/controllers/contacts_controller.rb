class ContactsController < ApplicationController
  def new
    @message = Message.new
  end

  def create
    message_params = params.expect(message: [:name, :email, :content])
    @message = Message.new(message_params)
  end
end
