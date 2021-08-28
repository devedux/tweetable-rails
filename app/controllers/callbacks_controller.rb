class CallbacksController < Devise::OmniauthCallbacksController
  before_action :set_user, only: %i[github google_oauth2 facebook]

  def github
    return sign_in_and_redirect @user, event: :authentication if @user.persisted?

    redirect_to new_user_registration_url
  end

  def google_oauth2
    return sign_in_and_redirect @user, event: :authentication if @user.persisted?

    redirect_to new_user_registration_url
  end

  def facebook
    return sign_in_and_redirect @user, event: :authentication if @user.persisted?

    redirect_to new_user_registration_url
  end

  private

  def set_user
    @user = User.from_omniauth(request.env['omniauth.auth'])
  end
end
