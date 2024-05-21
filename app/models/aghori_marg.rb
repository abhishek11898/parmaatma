class AghoriMarg < ApplicationRecord

  belongs_to :enlightened_being
  
  def self.images_folder_path
    folder_path = Rails.root.join('public', 'assets', 'aghori_marg', 'images')
    FileUtils.mkdir_p(folder_path) unless Dir.exist?(folder_path)
    folder_path
  end

  def self.videos_folder_path
    folder_path = Rails.root.join('public', 'assets', 'aghori_marg', 'videos')
    FileUtils.mkdir_p(folder_path) unless Dir.exist?(folder_path)
    folder_path
  end

  def self.relative_images_folder_path
    File.join('/', 'assets', 'aghori_marg', 'images')
  end

  def self.relative_videos_folder_path
    File.join('/', 'assets', 'aghori_marg', 'videos')
  end

  def absolute_image_url
    image_name ? File.join(AghoriMarg.images_folder_path, image_name) : ''
  end

  def absolute_video_url
    video ? File.join(AghoriMarg.videos_folder_path, video) : ''
  end

  def image_url
    image_name ? File.join(AghoriMarg.relative_images_folder_path, image_name) : ''
  end

  def video_url
    video ? File.join(AghoriMarg.relative_videos_folder_path, video) : ''
  end
end