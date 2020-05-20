module SessionsHelper
  def current_user
    # ||= は変数に値がnilであれば、右辺の値（またはメソッド）を代入することができる
    # また今回はログインしているかどうかを調べるものなので、user.findを使用してしまうと大抵の場合idはnilなのでエラーが起きてしまう。
    # find_byなら無ければnilを返すだけなので問題がない。
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    # !!の動作　すべてをtrueかfalseにする。ログインしていればtrueを返せる
    !!current_user
  end
end