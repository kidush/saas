module ApplicationHelper

  def get_info()

    User.where(invited_by_id: !nil)

  end

end
