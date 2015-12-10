class RegistrationsController < Devise::RegistrationsController
  def create
    super
    logging_in
  end
  protected
  def after_sign_up_path_for(resource)
    all_questions_path
  end
  def after_inactive_sign_up_path_for(resource)
    all_questions_path
  end
end