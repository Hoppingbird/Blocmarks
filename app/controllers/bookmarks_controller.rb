class BookmarksController < ApplicationController
  def show
    @topic = Topic.find(params[:topic_id])
    @bookmark = Bookmark.find(params[:id])
    @bookmarks = @topic.bookmarks

  end

  def new
    @topic = Topic.find(params[:topic_id])
    @bookmark = Bookmark.new
    authorize @bookmark
  end

  def edit
    @topic = Topic.find(params[:topic_id])
    @bookmark = Bookmark.find(params[:id])
  end

  def create
    @topic = Topic.find(params[:topic_id])
    @bookmark = @topic.bookmarks.build(bookmark_params)
    @bookmark.user = current_user
    authorize @bookmark
    if @bookmark.save
      redirect_to [@topic, @bookmark], notice: "Bookmark was saved successfully."
    else
      flash[:error] = "Well we got that wrong, please try again"
      render :new
    end
  end

  def update
    @topic = Topic.find(params[:topic_id])
    @bookmark = Bookmark.find(params[:id])
    authorize @bookmark
    if @bookmark.update_attributes(bookmark_params)
      redirect_to [@topic], notice: "bookmark edit successfully"
    else
      flash[:error] = "Whoa! There is a monkey with wrench in here, please try again"
      render :edit
    end
  end

  def destroy
    @topic = Topic.find(params[:topic_id])
    @bookmark = Bookmark.find(params[:id])
    authorize @bookmark
    if @bookmark.destroy
      flash[:notice] = "\"#{@topic.title}\" was deleted."
      redirect_to topics_path
    else
      flash[:error] = "Error deleting topic"
      render :show
    end
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:url)
  end

end
