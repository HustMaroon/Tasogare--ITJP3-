class MessageRoomsController < ApplicationController
	include ApplicationHelper
	before_action :admin_user, only:[:index]
	def index
		@message_rooms = MessageRoom.all
	end

	def show
		@message_room = MessageRoom.find(params[:id])
		@messages = @message_room.messages
	end

	def new
	end

	def create
		message_room = current_user.message_rooms.create!
		message_room.messages.build(content: params[:content], user: current_user).save
		redirect_to message_room
	end

end
