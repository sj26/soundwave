class Sound < ActiveRecord::Base
  mount_uploader :file, SoundFileUploader

  validates :file, presence: true

  def to_s
    File.basename file.to_s
  end
end
