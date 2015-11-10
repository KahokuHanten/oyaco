class UsersController < ApplicationController
  protect_from_forgery except: [:save_subscription_id, :clear_subscription_id]

  def save_subscription_id
    subscription_id = params[:subscription_id]
    if current_user
      current_user.update_attribute(:subscription_id, subscription_id)
    end
    render nothing: true
  end

  def clear_subscription_id
    if current_user
      current_user.update_attribute(:subscription_id, nil)
    end
    render nothing: true
  end
end
