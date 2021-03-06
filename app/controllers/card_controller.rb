class CardController < ApplicationController
  before_action :authenticate_user!
  before_action :set_card, only: %i(show edit update destroy)
  before_action :ensure_correct_user, only: %i(edit)

  def new
    @card = Card.new
    @list = List.find_by(id: params[:list_id])
  end

  def create
    @card = Card.new(card_params)
    if @card.save
      flash[:success] = "カードを作成しました"
      redirect_to list_index_path
    else
      render action: :new
    end
  end

  def show
    # @card = Card.find_by(id: params[:id])
  end

  def edit
    # @card = Card.find_by(id: params[:id])
    @lists = List.where(user: current_user)
  end

  def update
    # @card = Card.find_by(id: params[:id])
    if @card.update_attributes(card_params)
      flash[:success] = "カードを更新しました"
      redirect_to list_index_path
    else
      render action: :edit
    end
  end

  def destroy
    # @card = Card.find_by(id: params[:id])
    @card.destroy
    flash[:danger] = "カードを削除しました"
    redirect_to list_index_path
  end


  private
  
    def card_params
      params.require(:card).permit(:title, :memo, :list_id, :position)
    end

    def set_card
      @card = Card.find(params[:id])
    end

    def ensure_correct_user
      @card = Card.find(params[:id])
      @list = List.find_by(id: params[:list_id])
      if @list.user_id != current_user.id
        flash[:danger] = "権限がありません"
        redirect_to root_path
      end
    end

end
