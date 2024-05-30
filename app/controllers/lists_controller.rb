# app/controllers/lists_controller.rb
class ListsController < ApplicationController
  def index
    @lists = List.all
    @movies_by_list = {}  # Initialize a hash to store movies for each list

    # Fetch movies for each list
    @lists.each do |list|
      @movies_by_list[list] = list.movies
    end
  end

  def show
    @list = List.find(params[:id])
    @bookmarks = @list.bookmarks
    @movies = @list.movies
  end

  def new
    @list = List.new
  end


  def create
    @list = List.new(list_params)
    if @list.save
      redirect_to @list, notice: 'List was successfully created.'  # Redirect to the created list
    else
      render :new
    end
  end

  private

  def list_params
    params.require(:list).permit(:name)
  end
end
