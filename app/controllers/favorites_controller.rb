class FavoritesController < ApplicationController
  before_action :require_user_logged_in
  
  def create
    @like = Micropost.find(params[:micropost_id])
    current_user.favorite(@like)
    counts(current_user)
    # flash[:success] = '投稿をお気に入りに登録しました。'
    # redirect_to current_user
  end

  def destroy
    @like = Micropost.find(params[:micropost_id])
    current_user.unfavorite(@like)
    counts(current_user)
    # flash[:success] = '投稿をお気に入りから削除しました。'
    # redirect_to current_user
  end
end
