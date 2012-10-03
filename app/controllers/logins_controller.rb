class LoginsController < ApplicationController
  # GET /logins
  # GET /logins.json
  def show
    respond_to do |format|
      if logged_in?
        format.html # show.html.erb
        format.json { render json: @links }
      else
        error = 'Invalid Username or Password.'
        format.html { render action: "new" }
        format.json { render json: error, status: :bad_request }
      end
    end
  end

  # POST /logins
  # POST /logins.json
  def create
    user = User.find_by_username(params[:username])

    respond_to do |format|
      if user && user.authenticate(params[:password])
        session[:current_user_id] = user.id
        current_user
        format.html { render action: "show" }
        format.json { render json: @user }
      else
        flash[:error] = error = 'Invalid Username or Password.'
        format.html { render action: "new" }
        format.json { render json: error, status: :bad_request }
      end
    end
  end

  # DELETE /logins/slug
  # DELETE /logins/slug.json
  def destroy
    session[:current_user_id] = nil
    current_user

    respond_to do |format|
      format.html {
      	redirect_to root_url,
      	            :notice => "You have successfully logged out"
      }
      format.json { head :no_content }
    end
  end

end
