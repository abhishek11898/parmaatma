class TantraMarg < ApplicationRecord

  def self.images_folder_path
    folder_path = Rails.root.join('public', 'assets', 'tantra_yoga', 'images')
    FileUtils.mkdir_p(folder_path) unless Dir.exist?(folder_path)
    folder_path
  end

  def self.videos_folder_path
    folder_path = Rails.root.join('public', 'assets', 'tantra_yoga', 'videos')
    FileUtils.mkdir_p(folder_path) unless Dir.exist?(folder_path)
    folder_path
  end

  def self.relative_images_folder_path
    File.join('/', 'assets', 'tantra_yoga', 'images')
  end

  def self.relative_videos_folder_path
    File.join('/', 'assets', 'tantra_yoga', 'videos')
  end

  def absolute_image_url
    File.join(TantraMarg.images_folder_path, image_name)
  end

  def absolute_video_url
    File.join(TantraMarg.videos_folder_path, video)
  end

  def image_url
    image_name ? File.join(TantraMarg.relative_images_folder_path, image_name) : ''
  end

  def video_url
    File.join(TantraMarg.relative_videos_folder_path, video)
  end
end