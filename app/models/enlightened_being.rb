class EnlightenedBeing < ApplicationRecord
  def self.images_folder_path
    folder_path = Rails.root.join('public', 'assets', 'enlightened_being', 'images')
    FileUtils.mkdir_p(folder_path) unless Dir.exist?(folder_path)
    folder_path
  end

  def self.videos_folder_path
    folder_path = Rails.root.join('public', 'assets', 'enlightened_being', 'videos')
    FileUtils.mkdir_p(folder_path) unless Dir.exist?(folder_path)
    folder_path
  end

  def self.relative_images_folder_path
    File.join('/', 'assets', 'enlightened_being', 'images')
  end

  def absolute_image_url
    image_name ? File.join(EnlightenedBeing.images_folder_path, image_name) : ''
  end

  def image_url
    image_name ? File.join(EnlightenedBeing.relative_images_folder_path, image_name) : ''
  end
end