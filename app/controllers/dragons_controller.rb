class DragonsController < ApplicationController

  def index
    @dragons = Dragon.all

    render :index
  end


  def show
    @dragon = Dragon.find(params[:id])
    @requests = DragonRentalRequest.where("dragon_id = ?", params[:id]).order("start_date")

    render :show
  end

  def new
    @dragon = Dragon.new

    render :new
  end

  def create
    @dragon = Dragon.new(dragon_params)

    if @dragon.save(dragon_params)
      redirect_to dragon_url(@dragon)
    else
      @dragon.errors.full_messages
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

end