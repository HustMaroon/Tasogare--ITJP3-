class CommentsController < ApplicationController

	def new
	end

	def create
		@comment = current_user.comments.build(comment_params)
		if @comment.save
			respond_to do |format|
				format.html{redirect_to :back}
				format.js
			end
	  else
			flash[:warning]= "You can not comment on this review"
	  end
	end
private
	def comment_params
		params.require(:comment).permit(:content, :item_id)
	end
end
