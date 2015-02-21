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

	def team_params(params)
    	return params.permit(:team_name, :scavenger_id, :score)
  	end

end
