class TasksController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only:[:edit, :update, :destroy]
  
  def index
    @tasks = current_user.tasks.order(updated_at: :desc).page(params[:page]).per(15)
  end
  
  def new
    @task = current_user.tasks.build
  end
  
  def create
    @task = current_user.tasks.build(task_params)
    
    if @task.save
      flash[:success] = "タスクが正常に作成されました。"
      redirect_to root_url
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
    redirect_back(fallback_location: root_path)
  end
  
  private
  
  # Strong Parameter
  def task_params
    params.require(:task).permit(:content, :status)
  end
  
  #DRY
  def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
      redirect_to root_url
    end
  end
  
end
