class LeagueHeaderImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # process :scale => [800, 300]
  # process resize_to_fit: [800, 300]

  # def scale(width, height)
  #   # do something
  # end

  # version :thumb do
  #   process :resize_to_fit => [50, 50]
  # end

  # version :normal do
  #   process resize_to_fit: [800,300]
  # end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

end
