class BhaktiYogasController < ApplicationController
  def index 
    @bhakti_yogas = BhaktiYoga.limit(9)
    @total_records = @bhakti_yogas.count
  end

  def new 
    @bhakti_yoga = BhaktiYoga.new
  end

  def create
    @bhakti_yoga = BhaktiYoga.new(bhakti_yoga_params)
    if params[:bhakti_yoga][:image_name].present?
      image_tempfile = params[:bhakti_yoga][:image_name].tempfile
      image_original_filename = params[:bhakti_yoga][:image_name].original_filename
      image_extension = File.extname(image_original_filename)
      image_new_filename = "#{BhaktiYoga.count + 1}#{image_extension}" # Use BhaktiYoga.count to ensure unique filenames
      image_new_path = Rails.root.join(BhaktiYoga.images_folder_path, image_new_filename)
      FileUtils.cp(image_tempfile, image_new_path)

      @bhakti_yoga.image_name = image_new_filename
    end
    if params[:bhakti_yoga][:video].present?
      video_tempfile = params[:bhakti_yoga][:video].tempfile
      video_original_filename = params[:bhakti_yoga][:video].original_filename
      video_extension = File.extname(video_original_filename)
      video_new_filename = "#{BhaktiYoga.count + 1}#{video_extension}" # Use BhaktiYoga.count to ensure unique filenames
      video_new_path = Rails.root.join(BhaktiYoga.videos_folder_path, video_new_filename)
      FileUtils.cp(video_tempfile, video_new_path)

      @bhakti_yoga.video = video_new_filename
    end
    @bhakti_yoga.enlightened_being_id = ''
    if @bhakti_yoga.save
      flash[:success] = 'Bhakti Yoga post is successfully created'
      redirect_to bhakti_yoga_path(@bhakti_yoga)
    else
      flash[:error] = @bhakti_yoga.error
      render :new
    end
	end

  def show
    @bhakti_yoga = BhaktiYoga.find(params[:id])
  end

  def edit 
    @bhakti_yoga = BhaktiYoga.find(params[:id])
  end

  def update
    @bhakti_yoga = BhaktiYoga.find(params[:id])
    if params[:bhakti_yoga][:image_name].present?
      image_tempfile = params[:bhakti_yoga][:image_name].tempfile
      image_original_filename = params[:bhakti_yoga][:image_name].original_filename
      image_extension = File.extname(image_original_filename)
      image_new_filename = "#{@bhakti_yoga.image_name.split('.').first}#{image_extension}" 
      image_old_filename = @bhakti_yoga.image_name
      image_old_path = Rails.root.join(BhaktiYoga.images_folder_path, image_old_filename)
      image_new_path = Rails.root.join(BhaktiYoga.images_folder_path, image_new_filename)
      if File.exist?(image_old_path)
        File.delete(image_old_path)
      end
      FileUtils.cp(image_tempfile, image_new_path)
      @bhakti_yoga.image_name = image_new_filename
    end
    if params[:bhakti_yoga][:video].present?
      video_tempfile = params[:bhakti_yoga][:video].tempfile
      video_original_filename = params[:bhakti_yoga][:video].original_filename
      video_extension = File.extname(video_original_filename)
      video_new_filename = "#{@bhakti_yoga.video.split('.').first}#{video_extension}" 
      video_old_filename = @bhakti_yoga.video
      video_new_path = Rails.root.join(BhaktiYoga.videos_folder_path, video_new_filename)
      video_old_path = Rails.root.join(BhaktiYoga.videos_folder_path, video_old_filename)
      if File.exist?(video_old_path)
        File.delete(video_old_path)
      end
      FileUtils.cp(video_tempfile, video_new_path)
      @bhakti_yoga.video = video_new_filename
    end
    if @bhakti_yoga.update(bhakti_yoga_params)
      flash[:success] = 'Bhakti yoga item updated successfully.'
      redirect_to @bhakti_yoga
    else
      flash[:error] = 'Unable to update Bhakti yoga item.'
      render :edit
    end
  end

  def destroy
    @bhakti_yoga = BhaktiYoga.find(params[:id])
    if @bhakti_yoga.present?
      image_path = @bhakti_yoga.absolute_image_url
      video_path = @bhakti_yoga.absolute_video_url
      if File.exist?(image_path)
        File.delete(image_path)
      end
      if File.exist?(video_path)
        File.delete(video_path)
      end
      @bhakti_yoga.destroy
      flash[:success] = 'Item is Successfully deleted'
      redirect_to controller: 'bhakti_yogas', action: :index
    else
      flash[:Error] = 'Unable to delete Item'
      redirect_to bhakti_yoga_path(@bhakti_yoga)
    end
  end

  def get_more_bhakti_yogas_record_by_ajax
    total_records = params[:total_records].to_i # Convert to integer
    per_page = 9
    @bhakti_yogas = BhaktiYoga.offset(total_records).limit(per_page)
    respond_to do |format|
      format.js
      format.html { redirect_to root_path, alert: 'Invalid request format' } # Handle HTML format
    end
  end  

  private 

  def bhakti_yoga_params
    params.require(:bhakti_yoga).permit(:title, :description, :reference_name)
  end
end