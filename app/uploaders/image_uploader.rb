class ImageUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
   include CarrierWave::MiniMagick

  storage :aws

  def store_dir
    "uploads/widget/#{mounted_as}/#{model.id}"
  end



  def extension_whitelist
    %w(jpg jpeg gif png)
  end



end
