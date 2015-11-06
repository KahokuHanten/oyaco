ActiveAdmin.register User do
  permit_params :name, :email, :password, :password_confirmation

  member_action :push, method: :post do
    @user = User.find(params[:id])
    uri = URI.parse("https://android.googleapis.com/gcm/send")
    https = Net::HTTP.new(uri.host, uri.port)
    https.use_ssl = true
    req = Net::HTTP::Post.new(uri.request_uri)
    req["Content-Type"] = "application/json"
    req["Authorization"] = "key=" + ENV['GOOGLE_API_KEY']
    payload = {
      'registration_ids': [@user.subscription_id]
    }.to_json
    req.body = payload
    @res = https.request(req)
    render :push
  end

  action_item only: :show do
    link_to '通知', push_admin_user_path, method: :post if user.subscription_id.present?
  end

  index do
    selectable_column
    id_column
    column :name
    column :email
    column :subscription_id
    column :sign_in_count
    column :created_at
    actions defaults: true do |user|
      link_to '通知', push_admin_user_path(user), method: :post if user.subscription_id.present?
    end
  end

  filter :name
  filter :email
  filter :sign_in_count
  filter :created_at

  form do |f|
    f.inputs "User Details" do
      f.input :name
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end
end
