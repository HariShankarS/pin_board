class PinsController < ApplicationController
  before_action :find_pin, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  def index
  	@pins = Pin.all.order("created_at DESC")
  end

  def show  	
  end

  def edit
  end

  def update
  	if @pin.update(pin_params)
  	  redirect_to @pin, notice: "Successfully updated the Pin"
  	else
  	  render 'edit'
  	end
  end

  def destroy
  	@pin.destroy
  	redirect_to pins_path, notice: "Successfully deleted the Pin"
  end
 
  def new
  	@pin = Pin.new	
  end

  def create
  	@pin = Pin.new(pin_params)	
    @pin.user = current_user

  	if @pin.save
  	  redirect_to @pin, notice: "Successfully created New Pin"
  	else
  	  render 'new'
  	end

  end	

  private

  def find_pin
  	@pin = Pin.find(params[:id])
  end

  def pin_params
  	params.require(:pin).permit(:title, :description, :image)
  end
  
end
