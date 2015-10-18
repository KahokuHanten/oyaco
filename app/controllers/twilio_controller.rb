class TwilioController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:voice]

  def index
    account_sid = ENV['TWILIO_ACCOUNT_SID']
    auth_token = ENV['TWILIO_AUTH_TOKEN']

    capability = Twilio::Util::Capability.new account_sid, auth_token

    capability.allow_client_outgoing ENV['TWILIO_APP_SID']
    # capability.allow_client_incoming
    token = capability.generate
    render :index, locals: {token: token}
  end

  def voice
    number = params[:PhoneNumber]
    caller_id = ENV['TWILIO_CALLER_ID']
    response = Twilio::TwiML::Response.new do |r|
      r.Dial :callerId => caller_id do |d|
        d.Number(number.gsub('-', '').gsub(/\A0/, '+81'))
      end
    end
    render text: response.text
  end
end
