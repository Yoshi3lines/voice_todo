class Users::SessionsController < Devise::SessionsController
  def guest_sign_in
    # userモデルにクラスメソッドとして移行
    user = User.guest
    sign_in user
    redirect_to root_path, notice: 'ゲストユーザーとしてログインしました。'
  end
end