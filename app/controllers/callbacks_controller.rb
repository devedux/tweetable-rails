class CallbacksController < Devise::OmniauthCallbacksController
  def github
    @user = User.from_omniauth(request.env['omniauth.auth'])
    return sign_in_and_redirect @user, event: :authentication if @user.persisted?

    redirect_to new_user_registration_url
  end
end
