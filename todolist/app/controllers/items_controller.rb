class ItemsController < ApplicationController
    def index
      @list = List.find(params[:list_id])
      @items = @list.items
    end
  
    def show
      @item = Item.find(params[:id])
    end
  
    def new
      @list = List.find(params[:list_id])
      @item = @list.items.new
    end
  
    def create
      @list = List.find(params[:list_id])
      @item = @list.items.new(item_params)
      if @item.save
        redirect_to [@list, @item]
      else
        render :new
      end
    end
  
    def edit
      @item = Item.find(params[:id])
    end
  
    def update
      @item = Item.find(params[:id])
      if @item.update(item_params)
        redirect_to [@item.list, @item]
      else
        render :edit
      end
    end
  
    def destroy
      @item = Item.find(params[:id])
      @item.destroy
      redirect_to list_items_path(@item.list)
    end
  
    private
  
    def item_params
      params.require(:item).permit(:name, :list_id)
    end
end
  