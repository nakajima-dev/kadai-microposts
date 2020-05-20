module UsersHelper
  def gravatar_url(user, options = { size: 80 })
    # 下の構文がGravatarのデフォルト構文。downcaseで大文字を小文字に変換している。
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
  end
end