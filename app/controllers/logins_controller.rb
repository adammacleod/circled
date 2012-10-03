class LoginsController < ApplicationController
  # GET /logins
  # GET /logins.json
  def show
    respond_to do |format|
      if session[:current_user_id]
        format.html # show.html.erb
        format.json { render json: @links }
      else
        redirect_to new_logins_url
      end
    end
  end

  # GET /logins/new
  # GET /logins/new.json
  def new
    respond_to do |format|
      format.html # new.html.erb
      # TODO: This needs work
      format.json { render }
    end
  end

  # POST /logins
  # POST /logins.json
  def create
    user = User.find_by_username(params[:username])

    respond_to do |format|
      if user && user.authenticate(params[:password])
        session[:current_user_id] = user.id
        format.html { render action: "show" }
        format.json { render json: @user, status: :logged_in }
      else
      	# TODO: Display login error here
      	format.html { render action: "create" }
      	# TODO: @user.errors might not be appropriate, or might not exist.
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /logins/slug
  # DELETE /logins/slug.json
  def destroy
    session[:current_user_id] = nil

    respond_to do |format|
      format.html {
      	redirect_to root_url,
      	            :notice => "You have successfully logged out"
      }
      format.json { head :no_content }
    end
  end

end
