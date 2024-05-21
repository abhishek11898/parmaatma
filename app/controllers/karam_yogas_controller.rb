class KaramYogasController < ApplicationController
  def index 
    @karam_yogas = KaramYoga.limit(9)
    @total_records = @karam_yogas.count
  end

  def new 
    @karam_yoga = KaramYoga.new
  end

  def create
    @karam_yoga = KaramYoga.new(karam_yoga_params)
    if params[:karam_yoga][:image_name].present?
      image_tempfile = params[:karam_yoga][:image_name].tempfile
      image_original_filename = params[:karam_yoga][:image_name].original_filename
      image_extension = File.extname(image_original_filename)
      image_new_filename = "#{KaramYoga.count + 1}#{image_extension}" # Use KaramYoga.count to ensure unique filenames
      image_new_path = Rails.root.join(KaramYoga.images_folder_path, image_new_filename)
      FileUtils.cp(image_tempfile, image_new_path)

      @karam_yoga.image_name = image_new_filename
    end
    if params[:karam_yoga][:video].present?
      video_tempfile = params[:karam_yoga][:video].tempfile
      video_original_filename = params[:karam_yoga][:video].original_filename
      video_extension = File.extname(video_original_filename)
      video_new_filename = "#{KaramYoga.count + 1}#{video_extension}" # Use KaramYoga.count to ensure unique filenames
      video_new_path = Rails.root.join(KaramYoga.videos_folder_path, video_new_filename)
      FileUtils.cp(video_tempfile, video_new_path)

      @karam_yoga.video = video_new_filename
    end
    @karam_yoga.enlightened_being_id = ''
    if @karam_yoga.save
      flash[:success] = 'Karam Yoga post is successfully created'
      redirect_to karam_yoga_path(@karam_yoga)
    else
      flash[:error] = @karam_yoga.error
      render :new
    end
    end

  def show
    @karam_yoga = KaramYoga.find(params[:id])
  end

  def edit 
    @karam_yoga = KaramYoga.find(params[:id])
  end

  def update
    @karam_yoga = KaramYoga.find(params[:id])
    if params[:karam_yoga][:image_name].present?
      image_tempfile = params[:karam_yoga][:image_name].tempfile
      image_original_filename = params[:karam_yoga][:image_name].original_filename
      image_extension = File.extname(image_original_filename)
      image_new_filename = "#{@karam_yoga.image_name.split('.').first}#{image_extension}" 
      image_old_filename = @karam_yoga.image_name
      image_old_path = Rails.root.join(KaramYoga.images_folder_path, image_old_filename)
      image_new_path = Rails.root.join(KaramYoga.images_folder_path, image_new_filename)
      if File.exist?(image_old_path)
        File.delete(image_old_path)
      end
      FileUtils.cp(image_tempfile, image_new_path)
      @karam_yoga.image_name = image_new_filename
    end
    if params[:karam_yoga][:video].present?
      video_tempfile = params[:karam_yoga][:video].tempfile
      video_original_filename = params[:karam_yoga][:video].original_filename
      video_extension = File.extname(video_original_filename)
      video_new_filename = "#{@karam_yoga.video.split('.').first}#{video_extension}" 
      video_old_filename = @karam_yoga.video
      video_new_path = Rails.root.join(KaramYoga.videos_folder_path, video_new_filename)
      video_old_path = Rails.root.join(KaramYoga.videos_folder_path, video_old_filename)
      if File.exist?(video_old_path)
        File.delete(video_old_path)
      end
      FileUtils.cp(video_tempfile, video_new_path)
      @karam_yoga.video = video_new_filename
    end
    if @karam_yoga.update(karam_yoga_params)
      flash[:success] = 'Karam yoga item updated successfully.'
      redirect_to @karam_yoga
    else
      flash[:error] = 'Unable to update Karam yoga item.'
      render :edit
    end
  end

  def destroy
    @karam_yoga = KaramYoga.find(params[:id])
    if @karam_yoga.present?
      image_path = @karam_yoga.absolute_image_url
      video_path = @karam_yoga.absolute_video_url
      if File.exist?(image_path)
        File.delete(image_path)
      end
      if File.exist?(video_path)
        File.delete(video_path)
      end
      @karam_yoga.destroy
      flash[:success] = 'Item is Successfully deleted'
      redirect_to controller: 'karam_yogas', action: :index
    else
      flash[:Error] = 'Unable to delete Item'
      redirect_to karam_yoga_path(@karam_yoga)
    end
  end

  def get_more_karam_yogas_record_by_ajax
    total_records = params[:total_records].to_i # Convert to integer
    per_page = 9
    @karam_yogas = KaramYoga.offset(total_records).limit(per_page)
    respond_to do |format|
      format.js
    end
  end  

  private 

  def karam_yoga_params
    params.require(:karam_yoga).permit(:title, :description, :reference_name)
  end
end