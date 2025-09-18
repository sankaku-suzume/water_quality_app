module FlashesHelper
  def turbo_stream_flash
    turbo_stream.update 'flash', partial: 'commons/flash'
  end
end
