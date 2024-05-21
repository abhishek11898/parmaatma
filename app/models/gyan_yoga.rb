class GyanYoga < ApplicationRecord
  
  belongs_to :enlightened_being

  def self.images_folder_path
    folder_path = Rails.root.join('public', 'assets', 'gyan_yoga', 'images')
    FileUtils.mkdir_p(folder_path) unless Dir.exist?(folder_path)
    folder_path
  end

  def self.videos_folder_path
    folder_path = Rails.root.join('public', 'assets', 'gyan_yoga', 'videos')
    FileUtils.mkdir_p(folder_path) unless Dir.exist?(folder_path)
    folder_path
  end

  def self.relative_images_folder_path
    File.join('/', 'assets', 'gyan_yoga', 'images')
  end

  def self.relative_videos_folder_path
    File.join('/', 'assets', 'gyan_yoga', 'videos')
  end

  def absolute_image_url
    image_name ? File.join(GyanYoga.images_folder_path, image_name) : ''
  end

  def absolute_video_url
    video ? File.join(GyanYoga.videos_folder_path, video) : ''
  end

  def image_url
    image_name ? File.join(GyanYoga.relative_images_folder_path, image_name) : ''
  end

  def video_url
    video ? File.join(GyanYoga.relative_videos_folder_path, video) : ''
  end
end