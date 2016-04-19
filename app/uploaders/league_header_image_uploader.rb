class LeagueHeaderImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  #process resize_to_fit: [1920, 1920]

  # version :thumb do
  #   process :resize_to_fit => [50, 50]
  # end

  version :normal do
     process resize_to_fit: [1920,1920]
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

end
