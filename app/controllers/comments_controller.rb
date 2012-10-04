class CommentsController < ApplicationController
  skip_before_filter :require_login, :only => [:index, :show]

  # GET /links/:link_id/comments
  # GET /links/:link_id/comments.json
  def index
    @link = Link.find_by_slug(params[:link_id])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @link.comments }
    end
  end

  # GET /links/:link_id/comments/id
  # GET /links/:link_id/comments/id.json
  def show
    @link = Link.find_by_slug(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @link }
    end
  end

  # GET /links/:link_id/comments/new
  # GET /links/:link_id/comments/new.json
  def new
    @link = Link.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @link }
    end
  end

  # GET /links/:link_id/comments/id/edit
  def edit
    @link = Link.find_by_id(params[:id])
    unless @link.user == @current_user
      redirect_to @link
    end
  end

  # POST /links/:link_id/comments
  # POST /links/:link_id/comments.json
  def create
    @link = Link.new(params[:link])
    @link.user = @current_user

    respond_to do |format|
      if @link.save
        format.html { redirect_to @link, notice: 'Link was successfully created.' }
        format.json { render json: @link, status: :created, location: @link }
      else
        format.html { render action: "new" }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /links/:link_id/comments/id
  # PUT /links/:link_id/comments/id.json
  def update
    @link = Link.find_by_id(params[:id])

    respond_to do |format|
      if @link.user != @current_user
        flash[:error] = 'Unable to update links owned by other users.'
        format.html { render action: "show" }
        format.json { head :no_content }
      elsif @link.update_attributes(params[:link])
        format.html { redirect_to @link, notice: 'Link was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /links/:link_id/comments/id
  # DELETE /links/:link_id/comments/id.json
  def destroy
    @link = Link.find_by_id(params[:id])
    @link.destroy

    respond_to do |format|
      format.html { redirect_to links_url }
      format.json { head :no_content }
    end
  end
end
