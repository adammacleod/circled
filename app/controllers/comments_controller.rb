class CommentsController < ApplicationController
  skip_before_filter :require_login, :only => [:index, :show]

  # GET /links/:link_id/comments
  # GET /links/:link_id/comments.json
  def index
    @link = Link.find_by_slug(params[:link_id])
    @comments = @link.comments.where(:comment_id => nil)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @link.comments }
    end
  end

  # GET /links/:link_id/comments/id
  # GET /links/:link_id/comments/id.json
  def show
    @link = Link.find_by_slug(params[:link_id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @link }
    end
  end

  # GET /links/:link_id/comments/new
  # GET /links/:link_id/comments/new.json
  def new
    @link = Link.find_by_slug(params[:link_id])
    @comment = @link.comments.create()
    @comment.user = @current_user

    respond_to do |format|
      format.html # new.html.erb
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
    @link = Link.find_by_slug(params[:link_id])
    @comment = @link.comments.create(params[:comment])
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

  # POST /links/:link_id/comments/:id/reply
  def reply
    @parent = Comment.find_by_id(params[:id])
    @comment = @parent.comments.create(params[:comment])
    @comment.user = @current_user
    @comment.link = @parent.link
    @comment.save
    head :created
  end
end
