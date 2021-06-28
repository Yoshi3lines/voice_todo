class ListController < ApplicationController
  before_action :set_list, only: %i(edit update destroy)

  def new
    @list = List.new
  end

  def create
    @list = List.new(list_params)
    if @list.save
      flash[:success] = "リストを作成しました"
      redirect_to list_index_path(:show=>'all')
    else
      render action: :new
    end
  end

  def index
    # @lists = List.where(user: current_user).order("created_at ASC")
    @show = params[:show]
    if @show == "all" then
      @lists = List.where(user: current_user).order("created_at ASC")
    else
      @lists = List.where(user: current_user, completed: 0).order("created_at ASC")
    end
  end

  def edit
    # @list = List.find_by(id: params[:id])
  end

  def update
    # @list = List.find_by(id: params[:id])
    if @list.update_attributes(list_params)
      flash[:success] = "リスト名を変更しました"
      redirect_to list_index_path(:show=>'all')
    else
      render action: :edit
    end
  end

  def destroy
    if @list.audio.present?
      public_ids = [@list.audio.file.public_id]
      Cloudinary::Api.delete_resources(public_ids)
    end
    @list.destroy
    flash[:danger] = "リストを削除しました"
    redirect_to list_index_path(:show=>'all')
  end


  private
    def list_params
      params.require(:list).permit(:title, :audio, :completed).merge(user: current_user)
    end

    def set_list
      @list = List.find(params[:id])
    end

end
