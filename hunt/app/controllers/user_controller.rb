class UserController < ApplicationController
	def index
		@teams = Team.all
		user = User.find(params[:id])
		@title = user.user_name + "'s Dashboard"
		@myhunts = user.scavengers
		@myteams = user.teams
		@myphotos = user.photos
	end
	def login
		@title = "Login Page"
	end

	def post_login
		loginName = params[:logininfo]
		if User.exists?(:login => loginName) and User.find_by(login: loginName).password_valid?(params[:password])
			session[:login] = loginName
			redirect_to(:action => :index, :id => User.find_by(login: loginName))
		else
			flash[:notice] = 'login not successful'
			render(:action => :login)
		end
	end

	def logout
		reset_session
		redirect_to(:action => :login)
	end

	def new
		if session[:login]
			flash[:notice] = "You seem to be logged into an account. Log out to create a new user"
			redirect_to(:action => :index, :id => User.find_by(login: session[:login]).id)
		else
			@title = "Create a new user"
			@user = User.new
		end
	end

	def create
		@user = User.new(user_params(params[:user]))
		if @user.save
			flash[:notice] = "User created successfully"
			redirect_to(:action => :login)
		else
			flash[:notice] = 'User not successful'
			render(:action => :new)
		end
	end

	private
	def user_params(params)
		return params.permit(:user_name, :email, :password, :password_confirmation, :login)
	end

end
