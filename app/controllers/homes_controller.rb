class HomesController < ApplicationController
  skip_before_action :authenticate_user!

  def index
  end

  # def guest_sign_in
  #   user = User.find_or_create_by!(email: 'guest@example.com') do |user|
  #     user.password = SecureRandom.urlsafe_base64
  #     # user.confirmed_at = Time.now  # Confirmable を使用している場合は必要
  #   end
  #   sign_in user
  #   redirect_to root_path, notice: 'ゲストユーザーとしてログインしました。'
  # end
end
