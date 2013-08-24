class InputController < ApplicationController
  before_filter :authenticate_user!
  # get index
  def index
  end

  # post input
  def input
    string = params[:string]
    TranslateWorker.perform_async(string,current_user.id)
    #render :text => params.to_yaml
    #render :text => current_user.id
    redirect_to root_path , :flash => {:notice => '翻訳処理を開始しました。'}
  end
end
