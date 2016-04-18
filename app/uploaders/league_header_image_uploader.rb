class LeagueHeaderImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick


  # storage :file
  storage :fog

  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

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

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

end
