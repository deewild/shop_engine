class ItemsController < ApplicationController
  def show
    @item = Item.find(params[:id])
    @pictures = @item.item_pictures.order("main DESC")
    
    add_breadcrumb @item.category.parent_category.name, "/categories/#{@item.category.parent_category.alias}" if @item.category.parent_category
    add_breadcrumb @item.category.name, "/categories/#{@item.category.alias}"
    add_breadcrumb @item.name, "/items/#{@item.id}"
  end

  def order
    @item = Item.find(params[:id])

    if request.get?
      @order = @item.orders.build
      
      render :layout => false

    elsif request.post?
      @order = @item.orders.build(params[:order])

      @order.save
    end
  end

  def search
    @items = params[:item_name].blank? ? [] : Item.search_by_name(params[:item_name]).limit(100)

    @item_pictures = ItemPicture.fetch_for_item_list( @items.collect{ |i| i["id"] } )
  end
end