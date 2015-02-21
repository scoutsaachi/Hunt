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
	@scavenger.user = User.find_by(login: session[:login])
	if @scavenger.save
		flash[:notice] = "Scavenger created successfully"
		redirect_to(:controller => :user, :action => :index, :id => @scavenger.user.id)
	else
		flash[:notice] = 'Scavenger not successful'
		render(:action => :new)
	end
end

private
	def scavenger_params(params)
		return params.permit(:hunt_name, :location, :description)
	end

end
