class RentalsController < ApplicationController
  before_action :owns_dragon, only: [:approve, :deny]

  def index
    @rentals = DragonRentalRequest.all

    render :index
  end


  def show
    @rental = DragonRentalRequest.find(params[:id])

    render :show
  end

  def new
    @rental = DragonRentalRequest.new(dragon_id: params[:dragon_id])
    @dragons = Dragon.all

    render :new
  end

  def create
    @rental = DragonRentalRequest.new(dragon_rental_params)
    @dragons = Dragon.all

    if @rental.save(dragon_rental_params)
      redirect_to rentals_url
    else
      @rental.errors.full_messages
      render :new
    end
  end

  def edit
    @rental = DragonRentalRequest.find(params[:id])

    render :edit
  end

  def update
    @rental = DragonRentalRequest.find(params[:id])

    if @rental.update(dragon_rental_params)
      redirect_to rental_url(@rental)
    else
      @rental.errors.full_messages
      render :edit
    end
  end

  def destroy
    @rental = DragonRentalRequest.find(params[:id])

    if @rental.destroy
      redirect_to _url
    else
      @rental.errors.full_messages
      redirect_to rentals_url
    end
  end

  def approve
    @rental = DragonRentalRequest.find(params[:id])
    @rental.approve!
    @dragon = Dragon.find(@rental.dragon_id)

    redirect_to dragon_url(@dragon)
  end

  def deny
    @rental = DragonRentalRequest.find(params[:id])
    @rental.deny!

    render :show
  end

  private
  def dragon_rental_params
    rental_attrs = [:dragon_id, :start_date, :end_date]

    params.require(:rental).permit(*rental_attrs)
  end

  def owns_dragon
    @rental = DragonRentalRequest.find(params[:id])
    @dragon = Dragon.find(@rental.dragon_id)
    redirect_to dragons_url unless @dragon.owner == current_user
  end

end