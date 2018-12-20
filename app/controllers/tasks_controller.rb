class TasksController < ApplicationController
  before_action :set_tasks, only:[:show, :edit, :update, :destroy]
  
  def index
    @tasks = Task.order(updated_at: :desc).page(params[:page]).per(15)
  end
  
  def show
  end
  
  def new
    @task = Task.new
  end
  
  def create
    @task = Task.new(task_params)
    
    if @task.save
      flash[:success] = "タスクが正常に作成されました。"
      redirect_to task_url(@task)
    else
      flash[:danger] = "タスクが作成されませんでした。"
      render :new
    end
  end
  
  def edit
  end
  
  def update
    if @task.update(task_params)
      flash[:success] = "タスクが正常に更新されました。"
      redirect_to task_url(@task)
    else
      flash[:danger] = "タスクが更新されませんでした。"
      render :edit
    end
  end
  
  def destroy
    @task.destroy
    
    flash[:success] = "正常に削除されました。"
    redirect_to tasks_url
  end
  
  private
  # DRY
  def set_tasks
    @task = Task.find(params[:id])
  end
  
  # Strong Parameter
  def task_params
    params.require(:task).permit(:content, :status)
  end
  
end
