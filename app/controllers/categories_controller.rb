class CategoriesController < ApplicationController
  before_action :authenticate_user!
   
  def index
    @categories = current_user.categories.all
  end

  def show
    @category = current_user.categories.find(params[:id])
    # @tasks = @category.tasks.find(params[:id])
  end

  def new
    @category = current_user.categories.new
  end

  def create
    @category = current_user.categories.new(category_params)
    if @category.save
      redirect_to @category, notice: 'Category was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end


  def edit
    @category = current_user.categories.find(params[:id])
  end


  def update
    @category = current_user.categories.find(params[:id])

    if @category.update(category_params)
      redirect_to @category, notice: 'Category was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end


  def destroy
    @category = current_user.categories.find(params[:id])
    @category.destroy
    redirect_to categories_path, notice: "#{@category.name} was successfully destroyed."
  end

  
  private

  def category_params
    params.require(:category).permit(:name).merge(user_id: current_user.id)
  end  
end
