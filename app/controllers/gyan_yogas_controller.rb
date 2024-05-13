class GyanYogasController < ApplicationController
  def index 
    @gyan_yogas = GyanYoga.limit(9)
    @total_record = @gyan_yogas.count
  end

  def new 
    @gyan_yoga = GyanYoga.new
  end

  def create
    @gyan_yoga = GyanYoga.new(gyan_yoga_params)
    if params[:gyan_yoga][:image_name].present?
      image_tempfile = params[:gyan_yoga][:image_name].tempfile
      image_original_filename = params[:gyan_yoga][:image_name].original_filename
      image_extension = File.extname(image_original_filename)
      image_new_filename = "#{GyanYoga.count + 1}#{image_extension}" # Use GyanYoga.count to ensure unique filenames
      image_new_path = Rails.root.join(GyanYoga.images_folder_path, image_new_filename)
      FileUtils.cp(image_tempfile, image_new_path)

      @gyan_yoga.image_name = image_new_filename
    end
    if params[:gyan_yoga][:video].present?
      video_tempfile = params[:gyan_yoga][:video].tempfile
      video_original_filename = params[:gyan_yoga][:video].original_filename
      video_extension = File.extname(video_original_filename)
      video_new_filename = "#{GyanYoga.count + 1}#{video_extension}" # Use GyanYoga.count to ensure unique filenames
      video_new_path = Rails.root.join(GyanYoga.videos_folder_path, video_new_filename)
      FileUtils.cp(video_tempfile, video_new_path)

      @gyan_yoga.video = video_new_filename
    end
    @gyan_yoga.enlightened_being_id = ''
    if @gyan_yoga.save
      flash[:success] = 'Gyan Yoga post is successfully created'
      redirect_to gyan_yoga_path(@gyan_yoga)
    else
      flash[:error] = @gyan_yoga.error
      render :new
    end
    end

  def show
    @gyan_yoga = GyanYoga.find(params[:id])
  end

  def edit 
    @gyan_yoga = GyanYoga.find(params[:id])
  end

  def update
    @gyan_yoga = GyanYoga.find(params[:id])
    if @gyan_yoga.update(gyan_yoga_params)
      flash[:success] = 'Gyan yoga item updated successfully.'
      redirect_to @gyan_yoga
    else
      flash[:error] = 'Unable to update Gyan yoga item.'
      render :edit
    end
  end

  def destroy
    @gyan_yoga = GyanYoga.find(params[:id])
    if @gyan_yoga.present?
      image_path = @gyan_yoga.absolute_image_url
      video_path = @gyan_yoga.absolute_video_url
      if File.exist?(image_path)
        File.delete(image_path)
      end
      if File.exist?(video_path)
        File.delete(video_path)
      end
      @gyan_yoga.destroy
      flash[:success] = 'Item is Successfully deleted'
      redirect_to controller: 'gyan_yogas', action: :index
    else
      flash[:Error] = 'Unable to delete Item'
      redirect_to gyan_yoga_path(@gyan_yoga)
    end
  end

  def get_more_gyan_yoga_record_by_ajax
    total_records = params[:total_records].to_i # Convert to integer
    per_page = 10
    @gyan_yogas = GyanYoga.offset(total_records).limit(per_page)
    respond_to do |format|
      format.js
    end
  end  

  private 

  def gyan_yoga_params
    params.require(:gyan_yoga).permit(:title, :description, :reference_name)
  end
end