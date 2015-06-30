class TasksController < ApplicationController

	def create
		@project = Project.find(params[:project_id])
		@task = @project.tasks.create(task_params)
	
		respond_to do |format|	
			if @project.save
				format.html{ redirect_to project_path(@project.id), notice:'Project was successfully created.'}
				format.json{ rnder :show,status: :created, location:@project}
			else
				format.html{ redirect_to project_path(@project.id) }
				format.json{ render json:@project.errors,status: :unprocessabie_entry}
			end
		end
	end

	def destroy
		@task = Task.find(params[:id])
		@task.destroy
		redirect_to project_path(params[:project_id])
	end

	def toggle
		render nothing:true
		@task = Task.find(params[:id])
		@task.done = !@task.done
		@task.save
	end

	private
	def task_params
		params.require(:task).permit(:title)
	end
end

