class TasksController < ApplicationController
  before_action :authenticate_user!

    def index
      @category = current_user.categories.find(params[:category_id])
    @tasks = @category.tasks
    end

  
    def show

      @task = current_user.tasks.find(params[:id])
    end
  
    def new
      @category = current_user.categories.find(params[:category_id])
      @task = @category.tasks.build
    end
    
    def create
      @category = current_user.categories.find(params[:category_id])
      @task = @category.tasks.build(task_params)
      @task.user = current_user
    
      if @task.save
        redirect_to @category, notice: 'Task was successfully created.'
      else
        logger.debug @task.errors.full_messages # Add this line to log validation errors
        render :new
      end
    end    
  
    def edit
      @category = current_user.categories.find(params[:category_id])
      @task = @category.tasks.find(params[:id])
    end
   
    def update
      @category = current_user.categories.find(params[:category_id])
      @task = @category.tasks.find(params[:id])
    
      respond_to do |format|
        if @task.update(task_params)
          format.html { redirect_to category_path(@task.category_id), notice: "Task has been updated!" }
          format.json { render json: { status: 'success', task: @task } }
        else
          format.html { render :edit }
          format.json { render json: { status: 'error', errors: @task.errors.full_messages }, status: :unprocessable_entity }
        end
      end
    end    
  
    def destroy
        @task = current_user.tasks.find(params[:id])
      @task.destroy
      redirect_to category_task_path, info: "Task was successfully deleted"
    end
  
    private
  
    def task_params
      params.require(:task).permit(:name, :due_date, :status)
    end
end
