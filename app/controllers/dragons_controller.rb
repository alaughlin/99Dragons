class DragonsController < ApplicationController
  #before_action :not_logged_in
  before_action :owns_dragon, only: [:edit, :update]
  before_action :not_logged_in, only: [:new, :update, :destroy, :create, :destroy]

  def index
    @dragons = Dragon.all

    render :index
  end


  def show
    @dragon = Dragon.find(params[:id])
    @requests = DragonRentalRequest.includes(:user)
                .where("dragon_id = ?", params[:id])
                .order("start_date")
    render :show
  end

  def new
    @dragon = Dragon.new

    render :new
  end

  def create
    @dragon = Dragon.new(dragon_params)
    @dragon.user_id = current_user.id

    if @dragon.save
      redirect_to dragon_url(@dragon)
    else
      flash.now[:errors] = @dragon.errors.full_messages
      render :new
    end
  end

  def edit
    @dragon = Dragon.find(params[:id])

    render :edit
  end

  def update
    @dragon = Dragon.find(params[:id])

    if @dragon.update(dragon_params)
      redirect_to dragon_url(@dragon)
    else
      @dragon.errors.full_messages
      render :edit
    end
  end

  def destroy
    @dragon = Dragon.find(params[:id])

    if @dragon.destroy
      redirect_to dragons_url
    else
      @dragon.errors.full_messages
      redirect_to dragons_url
    end
  end

  private
  def dragon_params
    dragon_attrs = [:name, :age, :sex, :color, :description, :birth_date]

    params.require(:dragon).permit(*dragon_attrs)
  end

  def owns_dragon
    @dragon = Dragon.find(params[:id])
    redirect_to dragons_url unless @dragon.owner == current_user
  end

end