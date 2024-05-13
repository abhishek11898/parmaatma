class NadYogasController < ApplicationController
  def index 
    @nad_yogas = NadYoga.limit(9)
    @total_record = @nad_yogas.count
  end

  def new 
    @nad_yoga = NadYoga.new
  end

  def create
    @nad_yoga = NadYoga.new(nad_yoga_params)
    if params[:nad_yoga][:image_name].present?
      image_tempfile = params[:nad_yoga][:image_name].tempfile
      image_original_filename = params[:nad_yoga][:image_name].original_filename
      image_extension = File.extname(image_original_filename)
      image_new_filename = "#{NadYoga.count + 1}#{image_extension}" # Use NadYoga.count to ensure unique filenames
      image_new_path = Rails.root.join(NadYoga.images_folder_path, image_new_filename)
      FileUtils.cp(image_tempfile, image_new_path)

      @nad_yoga.image_name = image_new_filename
    end
    if params[:nad_yoga][:video].present?
      video_tempfile = params[:nad_yoga][:video].tempfile
      video_original_filename = params[:nad_yoga][:video].original_filename
      video_extension = File.extname(video_original_filename)
      video_new_filename = "#{NadYoga.count + 1}#{video_extension}" # Use NadYoga.count to ensure unique filenames
      video_new_path = Rails.root.join(NadYoga.videos_folder_path, video_new_filename)
      FileUtils.cp(video_tempfile, video_new_path)

      @nad_yoga.video = video_new_filename
    end
    @nad_yoga.enlightened_being_id = ''
    if @nad_yoga.save
      flash[:success] = 'Nad Yoga post is successfully created'
      redirect_to nad_yoga_path(@nad_yoga)
    else
      flash[:error] = @nad_yoga.error
      render :new
    end
    end

  def show
    @nad_yoga = NadYoga.find(params[:id])
  end

  def edit 
    @nad_yoga = NadYoga.find(params[:id])
  end

  def update
    @nad_yoga = NadYoga.find(params[:id])
    if @nad_yoga.update(nad_yoga_params)
      flash[:success] = 'Nad yoga item updated successfully.'
      redirect_to @nad_yoga
    else
      flash[:error] = 'Unable to update Nad yoga item.'
      render :edit
    end
  end

  def destroy
    @nad_yoga = NadYoga.find(params[:id])
    if @nad_yoga.present?
      image_path = @nad_yoga.absolute_image_url
      video_path = @nad_yoga.absolute_video_url
      if File.exist?(image_path)
        File.delete(image_path)
      end
      if File.exist?(video_path)
        File.delete(video_path)
      end
      @nad_yoga.destroy
      flash[:success] = 'Item is Successfully deleted'
      redirect_to controller: 'nad_yogas', action: :index
    else
      flash[:Error] = 'Unable to delete Item'
      redirect_to nad_yoga_path(@nad_yoga)
    end
  end

  def get_more_nad_yoga_record_by_ajax
    total_records = params[:total_records].to_i # Convert to integer
    per_page = 10
    @nad_yogas = NadYoga.offset(total_records).limit(per_page)
    respond_to do |format|
      format.js
    end
  end  

  private 

  def nad_yoga_params
    params.require(:nad_yoga).permit(:title, :description, :reference_name)
  end
end