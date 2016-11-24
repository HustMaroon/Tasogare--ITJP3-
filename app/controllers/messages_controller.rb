class MessagesController < ApplicationController

	def create
		if params[:message][:message_room].nil?
			message_room = MessageRoom.new
			users = User.all - User.general_users + current_user
			users.each do |u|
				message_room.users |+ u
			end
		else
			message_room = MessageRoom.find(params[:message][:message_room])
		end
			@message = message_room.messages.build(message_params)
			@message.user = current_user
			unless @message.save
				flash[:danger] = "unable to send message" 	
			end
			respond_to do |format|
				format.html {redirect_to message_room}
				format.js
			end
	end
private
	def message_params
		params.require(:message).permit(:content)
	end
end
