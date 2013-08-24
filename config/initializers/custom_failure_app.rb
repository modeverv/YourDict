class CustomFailureApp < Devise::FailureApp
  def redirect 
    # will be called wen some failure occurs. 
    # Like unauthorized, session_expiry etc
    message = warden.message || warden_options[:message]
    if message == :timeout
      # session expires
    else
      # unauthorized
      # redirect_to "facebook.com"
    end
  end
end
