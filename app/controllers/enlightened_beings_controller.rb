class EnlightenedBeingsController < ApplicationController
  def index 
    @enlightened_beings = EnlightenedBeing.limit(9)
    @total_records = @enlightened_beings.count
  end

  def new 
    @enlightened_being = EnlightenedBeing.new
  end

  def create
    @enlightened_being = EnlightenedBeing.new(enlightened_being_params)
    if params[:enlightened_being][:image_name].present?
      image_tempfile = params[:enlightened_being][:image_name].tempfile
      image_original_filename = params[:enlightened_being][:image_name].original_filename
      image_extension = File.extname(image_original_filename)
      image_new_filename = "#{EnlightenedBeing.count + 1}#{image_extension}" # Use EnlightenedBeing.count to ensure unique filenames
      image_new_path = Rails.root.join(EnlightenedBeing.images_folder_path, image_new_filename)
      FileUtils.cp(image_tempfile, image_new_path)

      @enlightened_being.image_name = image_new_filename
    end

    if @enlightened_being.save
      flash[:success] = 'Enlightened being record is successfully created'
      redirect_to enlightened_being_path(@enlightened_being)
    else
      flash[:error] = @enlightened_being.error
      render :new
    end
	end

  def show
    @enlightened_being = EnlightenedBeing.find(params[:id])
  end

  def edit 
    @enlightened_being = EnlightenedBeing.find(params[:id])
  end

  def update
    @enlightened_being = EnlightenedBeing.find(params[:id])
    if params[:enlightened_being][:image_name].present?
      image_tempfile = params[:enlightened_being][:image_name].tempfile
      image_original_filename = params[:enlightened_being][:image_name].original_filename
      image_extension = File.extname(image_original_filename)
      image_new_filename = "#{@enlightened_being.image_name.split('.').first}#{image_extension}" 
      image_old_filename = @enlightened_being.image_name
      image_old_path = Rails.root.join(EnlightenedBeing.images_folder_path, image_old_filename)
      image_new_path = Rails.root.join(EnlightenedBeing.images_folder_path, image_new_filename)
      if File.exist?(image_old_path)
        File.delete(image_old_path)
      end
      FileUtils.cp(image_tempfile, image_new_path)
      @enlightened_being.image_name = image_new_filename
    end
    if params[:enlightened_being][:video].present?
      video_tempfile = params[:enlightened_being][:video].tempfile
      video_original_filename = params[:enlightened_being][:video].original_filename
      video_extension = File.extname(video_original_filename)
      video_new_filename = "#{@enlightened_being.video.split('.').first}#{video_extension}" 
      video_old_filename = @enlightened_being.video
      video_new_path = Rails.root.join(EnlightenedBeing.videos_folder_path, video_new_filename)
      video_old_path = Rails.root.join(EnlightenedBeing.videos_folder_path, video_old_filename)
      if File.exist?(video_old_path)
        File.delete(video_old_path)
      end
      FileUtils.cp(video_tempfile, video_new_path)
      @enlightened_being.video = video_new_filename
    end
    if @enlightened_being.update(enlightened_being_params)
      flash[:success] = 'Enlightened being item updated successfully.'
      redirect_to @enlightened_being
    else
      flash[:error] = 'Unable to update Enlightened being item.'
      render :edit
    end
  end

  def destroy
    @enlightened_being = EnlightenedBeing.find(params[:id])
    if @enlightened_being.present?
      image_path = @enlightened_being.absolute_image_url
      if File.exist?(image_path)
        File.delete(image_path)
      end
      @enlightened_being.destroy
      flash[:success] = 'Item is Successfully deleted'
      redirect_to controller: 'enlightened_beings', action: :index
    else
      flash[:Error] = 'Unable to delete Item'
      redirect_to enlightened_being_path(@enlightened_being)
    end
  end

  def get_more_enlightened_beings_record_by_ajax
    total_records = params[:total_records].to_i # Convert to integer
    per_page = 10
    @enlightened_beings = EnlightenedBeing.offset(total_records).limit(per_page)
    respond_to do |format|
      format.js
    end
  end  

  private 

  def enlightened_being_params
    params.require(:enlightened_being).permit(:name, :about, :birth_date, :mahasamadhi, :country, :adress, :alive)
  end
end