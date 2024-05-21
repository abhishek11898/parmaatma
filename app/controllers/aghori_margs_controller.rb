class AghoriMargsController < ApplicationController
  def index 
    @aghori_margs = AghoriMarg.limit(9)
    @total_records = @aghori_margs.count
  end

  def new 
    @aghori_marg = AghoriMarg.new
  end

  def create
    @aghori_marg = AghoriMarg.new(aghori_marg_params)
    if params[:aghori_marg][:image_name].present?
      image_tempfile = params[:aghori_marg][:image_name].tempfile
      image_original_filename = params[:aghori_marg][:image_name].original_filename
      image_extension = File.extname(image_original_filename)
      image_new_filename = "#{AghoriMarg.count + 1}#{image_extension}" # Use AghoriMarg.count to ensure unique filenames
      image_new_path = Rails.root.join(AghoriMarg.images_folder_path, image_new_filename)
      FileUtils.cp(image_tempfile, image_new_path)

      @aghori_marg.image_name = image_new_filename
    end
    if params[:aghori_marg][:video].present?
      video_tempfile = params[:aghori_marg][:video].tempfile
      video_original_filename = params[:aghori_marg][:video].original_filename
      video_extension = File.extname(video_original_filename)
      video_new_filename = "#{AghoriMarg.count + 1}#{video_extension}" # Use AghoriMarg.count to ensure unique filenames
      video_new_path = Rails.root.join(AghoriMarg.videos_folder_path, video_new_filename)
      FileUtils.cp(video_tempfile, video_new_path)

      @aghori_marg.video = video_new_filename
    end
    @aghori_marg.enlightened_being_id = ''
    if @aghori_marg.save
      flash[:success] = 'Aghori Yoga post is successfully created'
      redirect_to aghori_marg_path(@aghori_marg)
    else
      flash[:error] = @aghori_marg.error
      render :new
    end
    end

  def show
    @aghori_marg = AghoriMarg.find(params[:id])
  end

  def edit 
    @aghori_marg = AghoriMarg.find(params[:id])
  end

  def update
    @aghori_marg = AghoriMarg.find(params[:id])
    if params[:aghori_marg][:image_name].present?
      image_tempfile = params[:aghori_marg][:image_name].tempfile
      image_original_filename = params[:aghori_marg][:image_name].original_filename
      image_extension = File.extname(image_original_filename)
      image_new_filename = "#{@aghori_marg.image_name.split('.').first}#{image_extension}" 
      image_old_filename = @aghori_marg.image_name
      image_old_path = Rails.root.join(AghoriMarg.images_folder_path, image_old_filename)
      image_new_path = Rails.root.join(AghoriMarg.images_folder_path, image_new_filename)
      if File.exist?(image_old_path)
        File.delete(image_old_path)
      end
      FileUtils.cp(image_tempfile, image_new_path)
      @aghori_marg.image_name = image_new_filename
    end
    if params[:aghori_marg][:video].present?
      video_tempfile = params[:aghori_marg][:video].tempfile
      video_original_filename = params[:aghori_marg][:video].original_filename
      video_extension = File.extname(video_original_filename)
      video_new_filename = "#{@aghori_marg.video.split('.').first}#{video_extension}" 
      video_old_filename = @aghori_marg.video
      video_new_path = Rails.root.join(AghoriMarg.videos_folder_path, video_new_filename)
      video_old_path = Rails.root.join(AghoriMarg.videos_folder_path, video_old_filename)
      if File.exist?(video_old_path)
        File.delete(video_old_path)
      end
      FileUtils.cp(video_tempfile, video_new_path)
      @aghori_marg.video = video_new_filename
    end
    if @aghori_marg.update(aghori_marg_params)
      flash[:success] = 'Aghori yoga item updated successfully.'
      redirect_to @aghori_marg
    else
      flash[:error] = 'Unable to update Aghori yoga item.'
      render :edit
    end
  end

  def destroy
    @aghori_marg = AghoriMarg.find(params[:id])
    if @aghori_marg.present?
      image_path = @aghori_marg.absolute_image_url
      video_path = @aghori_marg.absolute_video_url
      if File.exist?(image_path)
        File.delete(image_path)
      end
      if File.exist?(video_path)
        File.delete(video_path)
      end
      @aghori_marg.destroy
      flash[:success] = 'Item is Successfully deleted'
      redirect_to controller: 'aghori_margs', action: :index
    else
      flash[:Error] = 'Unable to delete Item'
      redirect_to aghori_marg_path(@aghori_marg)
    end
  end

  def get_more_aghori_margs_record_by_ajax
    total_records = params[:total_records].to_i # Convert to integer
    per_page = 9
    @aghori_margs = AghoriMarg.offset(total_records).limit(per_page)
    respond_to do |format|
      format.js
    end
  end  

  private 

  def aghori_marg_params
    params.require(:aghori_marg).permit(:title, :description, :reference_name)
  end
end