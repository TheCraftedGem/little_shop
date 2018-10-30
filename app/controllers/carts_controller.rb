class CartsController < ApplicationController
  def create
    item = Item.find(params[:item_id])
    @cart.add_item(item.id)
    session[:cart] = @cart.contents

    quantity = @cart.count_of(item.id)
    flash[:notice] = "You Have #{quantity} #{item.name}s In Your Cart"
    if params[:path] == nil
      redirect_to items_path
    else
      redirect_to params[:path]
    end
   end

   def index
    @items = @cart.contents.keys.map do |item_id|
      item = Item.find(item_id)
    end
    @total_price = @cart.contents.map do |item_id, quantity|
      Item.find(item_id).price * quantity
    end.sum
  end

  def destroy
    @cart.contents.clear
    redirect_to cart_path
  end
  # add item @cart.contents[params[:id]]
  def subtract_item
    item = Item.find(params[:id])
    if @cart.contents[params[:id]] == 1
      @cart.contents.except!(params[:id])
    else
      @cart.subtract_item(item.id)
    end
    redirect_to cart_path
  end
end
