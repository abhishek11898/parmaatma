class TantraMargsController < ApplicationController
  def index 
    @tantra_margs = TantraMarg.limit(9)
    @total_record = @tantra_margs.count
  end

  def new 
    @tantra_marg = TantraMarg.new
  end

  def create
    @tantra_marg = TantraMarg.new(tantra_marg_params)
    if params[:tantra_marg][:image_name].present?
      image_tempfile = params[:tantra_marg][:image_name].tempfile
      image_original_filename = params[:tantra_marg][:image_name].original_filename
      image_extension = File.extname(image_original_filename)
      image_new_filename = "#{TantraMarg.count + 1}#{image_extension}" # Use TantraMarg.count to ensure unique filenames
      image_new_path = Rails.root.join(TantraMarg.images_folder_path, image_new_filename)
      FileUtils.cp(image_tempfile, image_new_path)

      @tantra_marg.image_name = image_new_filename
    end
    if params[:tantra_marg][:video].present?
      video_tempfile = params[:tantra_marg][:video].tempfile
      video_original_filename = params[:tantra_marg][:video].original_filename
      video_extension = File.extname(video_original_filename)
      video_new_filename = "#{TantraMarg.count + 1}#{video_extension}" # Use TantraMarg.count to ensure unique filenames
      video_new_path = Rails.root.join(TantraMarg.videos_folder_path, video_new_filename)
      FileUtils.cp(video_tempfile, video_new_path)

      @tantra_marg.video = video_new_filename
    end
    @tantra_marg.enlightened_being_id = ''
    if @tantra_marg.save
      flash[:success] = 'Tantra Yoga post is successfully created'
      redirect_to tantra_marg_path(@tantra_marg)
    else
      flash[:error] = @tantra_marg.error
      render :new
    end
    end

  def show
    @tantra_marg = TantraMarg.find(params[:id])
  end

  def edit 
    @tantra_marg = TantraMarg.find(params[:id])
  end

  def update
    @tantra_marg = TantraMarg.find(params[:id])
    if @tantra_marg.update(tantra_marg_params)
      flash[:success] = 'Tantra yoga item updated successfully.'
      redirect_to @tantra_marg
    else
      flash[:error] = 'Unable to update Tantra yoga item.'
      render :edit
    end
  end

  def destroy
    @tantra_marg = TantraMarg.find(params[:id])
    if @tantra_marg.present?
      image_path = @tantra_marg.absolute_image_url
      video_path = @tantra_marg.absolute_video_url
      if File.exist?(image_path)
        File.delete(image_path)
      end
      if File.exist?(video_path)
        File.delete(video_path)
      end
      @tantra_marg.destroy
      flash[:success] = 'Item is Successfully deleted'
      redirect_to controller: 'tantra_margs', action: :index
    else
      flash[:Error] = 'Unable to delete Item'
      redirect_to tantra_marg_path(@tantra_marg)
    end
  end

  def get_more_tantra_marg_record_by_ajax
    total_records = params[:total_records].to_i # Convert to integer
    per_page = 10
    @tantra_margs = TantraMarg.offset(total_records).limit(per_page)
    respond_to do |format|
      format.js
    end
  end  

  private 

  def tantra_marg_params
    params.require(:tantra_marg).permit(:title, :description, :reference_name)
  end
end