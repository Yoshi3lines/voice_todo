class ListController < ApplicationController
  before_action :authenticate_user!
  before_action :set_list, only: %i(edit update destroy)
  before_action :ensure_correct_user, only: %i(edit update destroy)

  def new
    @list = List.new
  end
  
  def create
    @list = List.new(list_params)
    if @list.save
      flash[:success] = "リストを作成しました"
      redirect_to list_index_path
    else
      render action: :new
    end
  end

  def index
    # @lists = List.where(user: current_user).order("created_at ASC")
    @view = params[:view]
    if @view == "comp" then
      @lists = List.where(user: current_user, completed: 1).order("created_at ASC")
    elsif @view == "not" then
      @lists = List.where(user: current_user, completed: 0).order("created_at ASC")
    else
      @lists = List.where(user: current_user).order("created_at ASC")
    end
    @lists_ids = @lists.ids
  end

  def edit
    # @list = List.find_by(id: params[:id])
  end

  def update
    # @list = List.find_by(id: params[:id])
    if @list.update_attributes(list_params)
      flash[:success] = "リスト名を変更しました"
      redirect_to list_index_path
    else
      render action: :edit
    end
  end

  def destroy
    if @list.audio.present?
      public_ids = [@list.audio.file.public_id]
      Cloudinary::Api.delete_resources(public_ids)
    end
    if @list.destroy
      flash[:danger] = "リストを削除しました"
      redirect_to list_index_path
    else
      flash[:danger] = "リストが削除できませんでした"
      redirect_to list_index_path
    end
  end

  def sort
    @list = List.find(params[:id])
    child = @list.cards.find_by(position: params[:from].to_i)
    child.insert_at(params[:to].to_i)
    head :ok
  end


  private
  
    def list_params
      params.require(:list).permit(:title, :audio, :completed).merge(user: current_user)
    end

    def set_list
      @list = List.find(params[:id])
    end

    def ensure_correct_user
      if @list.user_id != current_user.id
        flash[:danger] = "権限がありません"
        redirect_to root_path
      end
    end

end
