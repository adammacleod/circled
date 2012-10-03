class UsersController < ApplicationController
  skip_before_filter :require_login, :only => [:new, :create]

  # GET /users
  # GET /users.json
  def index
    @user = @current_user

    respond_to do |format|
      format.html { render action: "show" }
      format.json { render json: @current_user }
    end
  end

  # GET /users/username
  # GET /users/username.json
  def show
    @user = User.find_by_username(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/username/edit
  def edit
    @user = User.find_by_username(params[:id])

    # Only allow users to edit themselves
    unless @user.id == @current_user.id
      redirect_to @user
    end
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        session[:current_user_id] = @user.id
        current_user
        flash[:notice] = "Your account, #{@user.username}, was successfully registered."
        format.html { redirect_to root_url }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/username
  # PUT /users/username.json
  def update
    @user = User.find_by_username(params[:id])

    # Only allow users to update themselves
    unless @user.id == @current_user.id
      redirect_to @user
    end

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/username
  # DELETE /users/username.json
  def destroy
    # Silly Human - Accounts can't be deleted.
    # TODO: Display a message about this, or remove it or something..

    respond_to do |format|
      format.html { redirect_to user_url }
      format.json { head :no_content }
    end
  end
end
