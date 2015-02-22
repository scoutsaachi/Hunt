class ScavengerController < ApplicationController

def new
	if !session[:login]
		flash[:notice] = "You need to be logged in to create a scavenger hunt!"
		redirect_to(:controller => :user, :action => :login)
	else
		@scavenger = Scavenger.new
		@title = "Create a scavenger hunt"
	end
end

def dashboard
	if !session[:login]
		flash[:notice] = "You need to be logged in to create a scavenger hunt!"
		redirect_to(:controller => :user, :action => :login)
	else
		@scavenger = Scavenger.find(param[:id])
		@title = @scavenger.name
	end
end

def create
	@scavenger = Scavenger.new(scavenger_params(params[:scavenger]))
	@scavenger.date_time = DateTime.now
	@scavenger.user_id = User.find_by(login: session[:login]).id
	if @scavenger.save
		flash[:notice] = "Scavenger created successfully"
		redirect_to(:controller => :user, :action => :index, :id => @scavenger.user.id)
	else
		flash[:notice] = 'Scavenger not successful'
		render(:action => :new)
	end
end

def new_task
	if !session[:login]
		flash[:notice] = "You need to be logged in to create a scavenger hunt!"
		redirect_to(:controller => :user, :action => :login)
	else
		@task = Task.new
		@title = "Create a task"
	end
end

def create_task
	@task = Task.new(task_params(params[:task]))
	if @task.save
		flash[:notice] = "Task created successfully"
		redirect_to(:controller => :scavenger, :action => :dashboard, :id => @task.scavenger.id)
	else
		flash[:notice] = 'Task not successful'
		render(:action => :new_task)

end

def create_comment
	@comment = Comment.new(task_params(params[:comment]))
	if @comment.save
		flash[:notice] = "Comment created successfully"
		redirect_to(:controller => :scavenger, :action => :dashboard, :id => @task.scavenger.id)
	else
		flash[:notice] = 'Comment not successful'
		render(:action => :new_task)

end

#/scavenger/newTeam/{scavengerid}
def newTeam
	if !session[:login]
			flash[:notice] = "You need to be logged in to comment on a page!"
			redirect_to(:controller => :users, :action => :login)
		else
			@team = Team.new
			@scavid = params[:id]
			@title = "Create a new team"
			@pagetitle = "Create a new team"
	end
end

def createTeam
	@team = Team.new(team_params(params[:team]))
	@team.scavenger_id = params[:id]
	@team.score = 0
	if @team.save
		flash[:notice] = "Team created successfully"
		redirect_to(:controller => :user, :action => :index, :id => User.find_by(login: session[:login]).id)
	else
		flash[:notice] = 'Team creation not successful'
		render(:action => :new, :id => params[:id])
	end
end

private
	def scavenger_params(params)
		return params.permit(:hunt_name, :location, :description)
	end
	def task_params(params)
		return params.permit(:task_name, :point)
	end

	def team_params(params)
    	return params.permit(:team_name, :scavenger_id, :score)
  	end

end
