class SetItemsController < ApplicationController
  before_action :authenticate_user!

  def create
    success = false
    if params[:user_set_id].present? && params[:user_set_item].present?
      user_set = current_sj_user.sets.find(params[:user_set_id])
      set_item = user_set.items.build(params[:user_set_item])
      success = set_item.save
    end

    if success
      render nothing: true, status: 200
    else
      render nothing: true, status: 500
    end
  end
end
