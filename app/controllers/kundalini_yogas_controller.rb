class KundaliniYogasController < ApplicationController
  def index 
    @kundalini_yogas = KundaliniYoga.limit(9)
    @total_record = @kundalini_yogas.count
  end

  def new 
    @kundalini_yoga = KundaliniYoga.new
  end

  def create
    @kundalini_yoga = KundaliniYoga.new(kundalini_yoga_params)
    if params[:kundalini_yoga][:image_name].present?
      image_tempfile = params[:kundalini_yoga][:image_name].tempfile
      image_original_filename = params[:kundalini_yoga][:image_name].original_filename
      image_extension = File.extname(image_original_filename)
      image_new_filename = "#{KundaliniYoga.count + 1}#{image_extension}" # Use KundaliniYoga.count to ensure unique filenames
      image_new_path = Rails.root.join(KundaliniYoga.images_folder_path, image_new_filename)
      FileUtils.cp(image_tempfile, image_new_path)

      @kundalini_yoga.image_name = image_new_filename
    end
    if params[:kundalini_yoga][:video].present?
      video_tempfile = params[:kundalini_yoga][:video].tempfile
      video_original_filename = params[:kundalini_yoga][:video].original_filename
      video_extension = File.extname(video_original_filename)
      video_new_filename = "#{KundaliniYoga.count + 1}#{video_extension}" # Use KundaliniYoga.count to ensure unique filenames
      video_new_path = Rails.root.join(KundaliniYoga.videos_folder_path, video_new_filename)
      FileUtils.cp(video_tempfile, video_new_path)

      @kundalini_yoga.video = video_new_filename
    end
    @kundalini_yoga.enlightened_being_id = ''
    if @kundalini_yoga.save
      flash[:success] = 'Kundalini Yoga post is successfully created'
      redirect_to kundalini_yoga_path(@kundalini_yoga)
    else
      flash[:error] = @kundalini_yoga.error
      render :new
    end
    end

  def show
    @kundalini_yoga = KundaliniYoga.find(params[:id])
  end

  def edit 
    @kundalini_yoga = KundaliniYoga.find(params[:id])
  end

  def update
    @kundalini_yoga = KundaliniYoga.find(params[:id])
    if @kundalini_yoga.update(kundalini_yoga_params)
      flash[:success] = 'Kundalini yoga item updated successfully.'
      redirect_to @kundalini_yoga
    else
      flash[:error] = 'Unable to update Kundalini yoga item.'
      render :edit
    end
  end

  def destroy
    @kundalini_yoga = KundaliniYoga.find(params[:id])
    if @kundalini_yoga.present?
      image_path = @kundalini_yoga.absolute_image_url
      video_path = @kundalini_yoga.absolute_video_url
      if File.exist?(image_path)
        File.delete(image_path)
      end
      if File.exist?(video_path)
        File.delete(video_path)
      end
      @kundalini_yoga.destroy
      flash[:success] = 'Item is Successfully deleted'
      redirect_to controller: 'kundalini_yogas', action: :index
    else
      flash[:Error] = 'Unable to delete Item'
      redirect_to kundalini_yoga_path(@kundalini_yoga)
    end
  end

  def get_more_kundalini_yoga_record_by_ajax
    total_records = params[:total_records].to_i # Convert to integer
    per_page = 10
    @kundalini_yogas = KundaliniYoga.offset(total_records).limit(per_page)
    respond_to do |format|
      format.js
    end
  end  

  private 

  def kundalini_yoga_params
    params.require(:kundalini_yoga).permit(:title, :description, :reference_name)
  end
end