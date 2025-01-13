class ListsController < ApplicationController
    before_action :set_list, only: [:show, :update, :destroy]
  
    # GET /lists
    def index
      @lists = List.all
      render json: @lists, status: :ok
    end
  
    # GET /lists/:id
    def show
      render json: @list, status: :ok
    end
  
    # POST /lists
    def create
      @list = List.new(list_params)
      if @list.save
        render json: @list, status: :created
      else
        render json: { errors: @list.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    # PUT/PATCH /lists/:id
    def update
      if @list.update(list_params)
        render json: @list, status: :ok
      else
        render json: { errors: @list.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    # DELETE /lists/:id
    def destroy
      @list.destroy
      head :no_content
    end
  
    private
  
    # Set the list based on the ID in the params
    def set_list
      @list = List.find_by(id: params[:id])
      render json: { error: "List not found" }, status: :not_found unless @list
    end
  
    # Strong parameters for the list
    def list_params
      params.require(:list).permit(:name)
    end
  end
  