class AdminDashboardController < ApplicationController

  def index
    @admin = user_scope.all.paginate(page: params[:page], per_page: 1)
  end

  private

  def user_scope
    current_user ? Account.where.not(id: current_user.id) : Account.all
  end

end
