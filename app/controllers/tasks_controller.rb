class TasksController < ApplicationController
  before_action :set_category, except: [:update, :destroy]

    def index
      @tasks = @category.tasks
    end
  
    def show
      @task = current_user.tasks.find(params[:id])
    end
  
    def new
      @task = @category.tasks.build
    end
    
    def create
      @task = @category.tasks.build(task_params)
      @task.status = 0
      @task.user = current_user
    
      if @task.save
        redirect_to @category, notice: 'Task was successfully created.'
      else
        render :new
      end
    end    
  
    def edit
      @task = @category.tasks.find(params[:id])
    end
   
    def update
      @task = current_user.tasks.find(params[:id])
  
      respond_to do |format|
        if @task.update(task_params)
          format.html { redirect_to @task.category, notice: "Task has been updated!" }
        else
          format.html { render :edit }
        end
      end
    end
  
    def destroy
      @task = current_user.tasks.find(params[:id])
      @task.destroy
      redirect_to category_task_path, info: "Task was successfully deleted"
    end
  
    private

    def set_category
      @category = current_user.categories.find(params[:category_id])
    end
  
    def task_params
      params.require(:task).permit(:name, :due_date, :status)
    end
end
