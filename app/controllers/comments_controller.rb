class CommentsController < ApplicationController
  skip_before_filter :require_login, :only => [:index, :show]
  before_filter :load_link

  # GET /links/:link_id/comments
  # GET /links/:link_id/comments.json
  def index
    @comments = @link.comments.arrange(:order => :created_at)
    @comment = Comment.new()

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @link.comments }
    end
  end

  # GET /links/:link_id/comments/id
  # GET /links/:link_id/comments/id.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @link }
    end
  end

  # GET /links/:link_id/comments/new
  # GET /links/:link_id/comments/new.json
  def new
    @comment = Comment.new(:parent_id => params[:parent_id])

    respond_to do |format|
      format.html # new.html.erb
      format.js
      format.json { render json: @comment }
    end
  end

  # GET /links/:link_id/comments/id/edit
  def edit
    redirect_to Comment.find_by_id(params[:id])
  end

  # POST /links/:link_id/comments
  # POST /links/:link_id/comments.json
  def create
    @comment = @link.comments.build(params[:comment])
    @comment.user = @current_user

    respond_to do |format|
      if @comment.save
        format.html { redirect_to link_comments_url(@link), notice: 'Comment was created successfully' }
        format.json { render json: @comment, status: :created, location: @comment }
      else
        format.html { redirect_to link_comments_url(@link), error: 'Comment creation failed' }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /links/:link_id/comments/id
  # PUT /links/:link_id/comments/id.json
  def update
    redirect_to Comment.find_by_id(params[:id])
  end

  # DELETE /links/:link_id/comments/id
  # DELETE /links/:link_id/comments/id.json
  def destroy
    redirect_to Comment.find_by_id(params[:id])
  end

  def load_link
    @link = Link.find_by_slug(params[:link_id])
  end
end
