class SoundFileUploader < CarrierWave::Uploader::Base
  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_white_list
    %w(ogg mp3 m4a)
  end

  version :waveform do
    process :convert_to_waveform

    def convert_to_waveform
      cache_stored_file! if !cached?
      Dir::Tmpname.create(File.basename(current_path)) do |tempname|
        begin
          system %Q{ffmpeg -y -i "#{current_path}" -f wav "#{tempname}" > /dev/null 2>&1}
          FileUtils.rm current_path
          Waveform.new(tempname).generate(current_path)
        ensure
          FileUtils.rm tempname
        end
      end
    end
  end
end
