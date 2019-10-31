class TasksController < ApplicationController
before_action :set_task, only: [:show, :edit, :update, :destroy]
    def index
        if logged_in?
            @task = current_user.tasks.build
            @tasks = current_user.tasks.order(id: :desc).page(params[:page])
        end
    end
    
    def show
    end
    
    def new
        @task = Task.new
    end
    
    def create
        @task = Task.new(task_params)

        if @task.save
            flash[:success] = "タスクが登録されました"
            redirect_to @task
        else
            flash.now[:danger] = "登録に失敗しました"
            render :new
        end
    end
    
    def edit
    end
    
    def update
        if @task.update(task_params)
            flash[:success] = "タスクは更新されました"
            redirect_to @task
        else
            flash.now[:danger] = "更新に失敗しました"
            render :edit
        end
    end
    
    def destroy
        @task.destroy
        
        flash[:success] = "タスクは削除されました"
        redirect_to tasks_url
    end

    private

    def set_task
        @task = Task.find(params[:id])
    end

    def task_params
        params.require(:task).permit(:content, :status, :user_id)
    end
end