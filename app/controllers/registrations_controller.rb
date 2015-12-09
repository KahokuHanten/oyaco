class RegistrationsController < Devise::RegistrationsController
  protected
  def after_sign_up_path_for(resource)
    all_questions_path
  end
  def after_inactive_sign_up_path_for(resource)
    all_questions_path
  end
end