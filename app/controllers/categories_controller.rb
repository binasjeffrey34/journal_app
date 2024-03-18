class CategoriesController < ApplicationController
  before_action :set_category, except: [:new, :create, :index]

  def index
    @categories = current_user.categories.order(created_at: :asc)
  end

  def show
    @tasks = @category.tasks.order(id: :asc)
  end

  def new
    @category = current_user.categories.new
  end

  def create
    @category = current_user.categories.new(category_params)
    if @category.save
      flash[:notice] = "Category name successfully updated!"
      redirect_to categories_path
    else
      render :new, status: :unprocessable_entity
    end
  end


  def edit 
  end


  def update
    if @category.update(category_params)
      flash[:notice] = "Category name successfully updated!"
      redirect_to categories_path
    else
      render :edit, status: :unprocessable_entity
    end
  end


  def destroy
    @category.destroy
    redirect_to categories_path, notice: "#{@category.name} was successfully destroyed."
  end

  
  private

  def set_category
    @category = current_user.categories.find(params[:id])
  end


  def category_params
    params.require(:category).permit(:name).merge(user_id: current_user.id)
  end  
end
