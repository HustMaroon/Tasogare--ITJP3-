module ApplicationHelper
	def admin_user
		unless current_user.admin?
			flash[:danger]= "You don't have permission to access this page"
			redirect_to root_url
		end
	end

	def logged_in_user
    if current_user.nil?
      flash[:danger] = "Please log in."
      redirect_to new_user_session_path
    end
  end
end
