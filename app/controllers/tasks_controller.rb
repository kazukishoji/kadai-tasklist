class TasksController < ApplicationController
    def index
        @tasks = Task.all
    end
    
    def show
        @task = Task.find(params[:id])
    end
    
    def new
        @task = Task.new
    end
    
    def create
        @task = Task.new(task_params)
        
        if @task.save
            flash[:success] = "タスクが登録されました"
            redirect_to task_path
        else
            flash.now[:danger] = "登録に失敗しました"
            render :new
        end
    end
    
    def edit
        @task = Task.find(params[:id])
    end
    
    def update
        @task = Task.find(params[:id])
        
        if @task.update(task_params)
            flash[:success] = "タスクは更新されました"
            redirect_to task_path
        else
            falsh.now[:danger] = "更新に失敗しました"
            render :edit
        end
    end
    
    def destroy
        @task = Task.find(params[:id])
        @task.destroy
        
        flash[:success] = "タスクは削除されました"
        redirect_to tasks_url
    end
end

private

def task_params
    params.require(:task).permit(:content)
end