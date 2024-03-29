class LinksController < ApplicationController
  skip_before_filter :require_login, :only => [:index, :show]

  # GET /links
  # GET /links.json
  def index
    @links = Link.order("score DESC")

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @links }
    end
  end

  # GET /links/slug
  # GET /links/slug.json
  def show
    @link = Link.find_by_slug(params[:id])

    respond_to do |format|
      format.html { redirect_to @link.link }
      format.json { render json: @link }
    end
  end

  # GET /links/new
  # GET /links/new.json
  def new
    @link = Link.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @link }
    end
  end

  # GET /links/slug/edit
  def edit
    @link = Link.find_by_slug(params[:id])
    unless @link.user == @current_user
      redirect_to link_comments_url(@link)
    end
  end

  # POST /links
  # POST /links.json
  def create
    @link = Link.new(params[:link])
    @link.user = @current_user

    respond_to do |format|
      if @link.save
        format.html { redirect_to link_comments_url(@link), notice: 'Link was successfully created.' }
        format.json { render json: link_comments_url(@link), status: :created, location: link_comments_url(@link) }
      else
        format.html { render action: "new" }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /links/slug
  # PUT /links/slug.json
  def update
    @link = Link.find_by_slug(params[:id])

    respond_to do |format|
      if @link.user != @current_user
        flash[:error] = 'Unable to update links owned by other users.'
        format.html { render action: "show" }
        format.json { head :no_content }
      elsif @link.update_attributes(params[:link])
        format.html { redirect_to link_comments_url(@link), notice: 'Link was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /links/slug
  # DELETE /links/slug.json
  def destroy
    @link = Link.find_by_slug(params[:id])
    @link.comments.each do |c|
      c.destroy
    end
    @link.destroy

    respond_to do |format|
      format.html { redirect_to root_url, notice: 'BLAM! Link was thoroughly destroyed!' }
      format.json { head :no_content }
    end
  end

  # POST /links/slug/upvote
  def upvote
    # This will fail BADLY if two people vote at the exact same time.
    # This should really be a SQL statement that gets executed atomically.
    @link = Link.find_by_slug(params[:id])
    @link.score += 1
    @link.save

    respond_to do |format|
      format.js { render "vote" }
    end
  end

  # POST /links/slug/downvote
  def downvote
    # This will fail BADLY if two people vote at the exact same time.
    # This should really be a SQL statement that gets executed atomically.
    @link = Link.find_by_slug(params[:id])
    @link.score -= 1
    @link.save

    respond_to do |format|
      format.js { render "vote" }
    end
  end
end
