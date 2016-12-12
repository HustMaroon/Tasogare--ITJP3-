module ApplicationHelper
	def admin_user
		unless current_user.admin?
			flash[:danger]= "あなたはこのページにアクセス評価がありません。"
			redirect_to root_url
		end
	end

	def logged_in_user
    if current_user.nil?
      flash[:danger] = "ログインしてください。"
      redirect_to new_user_session_path
    end
  end

  def check_for_messages
		if current_user.admin?
			@new_messages = 0;
			MessageRoom.all.each do |mr|
				@new_messages+= 1 if !mr.messages.last.nil? && mr.messages.last.user != current_user
			end
		else
			@new_messages = 0;
			@new_messages +=1 if !(current_user.message_rooms.first.nil?) && 
				(current_user.message_rooms.first.messages.last.user != current_user) 
		end 
		return @new_messages
	end

	def notify_to_admin(item)
		User.where(admin: true).each do |admin|
			admin.notifications.create(kind: 1, item: item)
		end
	end

	def notify_to_user(user,item)
		user.notifications.create(kind: 2, item: item)
	end

	def get_notifications
		current_user.notifications.where(read: false)[0..9]
	end

	def full_title(page_title = '')
    base_title = "黄昏"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end
end
