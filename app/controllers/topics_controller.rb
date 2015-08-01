class TopicsController < ApplicationController
  def index
    @topics = Topic.all
  end

  def show
    @topic = Topic.find(params[:id])
    @bookmarks = @topic.bookmarks
  end

  def new
    @topic = Topic.new
  end

  def edit
    @topic = Topic.find(params[:id])
    @topic.save!
  end

  def create
    @topic = Topic.new(params.require(:topic).permit(:title))
    @topic.user = current_user
    if @topic.save
      flash[:notice] = 'Topic created!'
      redirect_to @topic
    else
      flash[:error] = 'Oops, something went wrong. Please try again'
      render :new
    end
  end

  def update
    @topic = Topic.find(params(:id))
    if @topic.update_attributes(params.require(:topic).permit(:title))
      flash[:notice ] = 'Update successful!'
      redirect_to @topic
    else
      flash[:error] = 'Ok, that did not work as expected. Please try again'
      render :edit
    end
  end

  def destroy
    @topic = Topic.find(params[:id])
    if @topic.destroy
      flash[:notice] = "\"#{@topic.title}\" was deleted."
      redirect_to topics_path
    else
      flash[:error] = 'The force is strong with this one. Please try again'
      render :show
    end
  end
end
