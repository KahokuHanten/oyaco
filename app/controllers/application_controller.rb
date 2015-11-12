class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_or_guest_user

  before_filter :configure_permitted_parameters, if: :devise_controller?
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name
    devise_parameter_sanitizer.for(:account_update) << :name
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  def after_sign_in_path_for(resource)
    stored_location_for(resource) ||
      if resource.is_a?(AdminUser)
        admin_dashboard_path
      else
        home_path
      end
  end

  # if user is logged in, return current_user, else return guest_user
  def current_or_guest_user
    if current_user
      if cookies.signed[:guest_user_email]
        logging_in
        guest_user.delete
        cookies.delete :guest_user_email
      end
      current_user
    else
      guest_user
    end
  end

  # find guest_user object associated with the current session,
  # creating one as needed
  def guest_user
    # Cache the value the first time it's gotten.
    @cached_guest_user ||= User.find_by!(email: (cookies.permanent.signed[:guest_user_email] ||= create_guest_user.email))

  # if cookies.signed[:guest_user_email] invalid
  rescue ActiveRecord::RecordNotFound
      cookies.delete :guest_user_email
      guest_user
  end

  private

  # called (once) when the user logs in, insert any code your application needs
  # to hand off from guest_user to current_user.
  def logging_in
    # TODO:
    # put all your processing for transferring
    # from a guest user to a registered user
    # i.e. update votes, update comments, etc.
  end

  # creates guest user by adding a record to the DB
  # with a guest name and email
  def create_guest_user
    u = User.create(name: 'guest', email: "guest_#{Time.now.to_i}#{rand(99)}@example.com")
    # u.skip_confirmation!
    u.save!(validate: false)
    u
  end

end
