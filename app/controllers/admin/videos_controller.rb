class Admin::VideosController < AdminsController
  def new
    @video = Video.new
  end

  def create
    @video = Video.new(video_params)

    if @video.save
      flash[:success] = "Video Added!"
      redirect_to new_admin_video_path
    else
      flash[:error] = "Please fix the following errors!"
      render :new
    end
  end


  private

  def video_params
    params.require(:video).permit(:title, :description, :category_id, :small_cover, :large_cover)
  end

end
