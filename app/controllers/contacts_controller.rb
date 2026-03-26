class ContactsController < ApplicationController
  def new
    @message = Message.new
  end

  def create
    message_params = params.expect(message: [:name, :email, :content])
    @message = Message.new(message_params)

    if @message.save
      redirect_to root_path, notice: "Sent successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end
end
