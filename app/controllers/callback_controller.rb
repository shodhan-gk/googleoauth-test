class CallbackController < ApplicationController
 def google_onetap
    if g_csrf_token_valid?
      payload = Google::Auth::IDTokens.verify_oidc(params[:credential], aud: ENV['GOOGLE_CLIENT_ID'])
      user = User.from_google_payload(payload)
      sign_in(user) # this sign_in comes from devise, yours may differ
      redirect_to(root_path)
    else
      redirect_to(user_session_path, notice: 'sign in failed')
    end
  end

  private

  def g_csrf_token_valid?
    cookies['g_csrf_token'] == params['g_csrf_token']
  end
end
