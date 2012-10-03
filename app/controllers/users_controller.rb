class UsersController < ApplicationController
  # GET /user
  # GET /user.json
  def index
    ##
    # TODO:
    #  - find the currently logged in user
    #  - If there isn't one redirect to login
    @user = User.all.first

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @user }
    end
  end

  # GET /user/username
  # GET /user/username.json
  def show
    @user = User.find_by_username(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /user/new
  # GET /user/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /user/username/edit
  def edit
    @user = User.find_by_username(params[:id])
  end

  # POST /user
  # POST /user.json
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /user/username
  # PUT /user/username.json
  def update
    @user = User.find_by_username(params[:id])

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

  # DELETE /user/username
  # DELETE /user/username.json
  def destroy
    # Silly Human - Accounts can't be deleted.
    # TODO: Display a message about this, or remove it or something..

    respond_to do |format|
      format.html { redirect_to user_url }
      format.json { head :no_content }
    end
  end
end
