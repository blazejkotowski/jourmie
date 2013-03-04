CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',                                     # required
    :aws_access_key_id      => 'AKIAIFUSUIULKFP45S5Q',                    # required
    :aws_secret_access_key  => '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', # required
  }
  config.fog_directory  = 'jourmie'                     # required
  config.fog_public     = false                                   # optional, defaults to true
  config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}  # optional, defaults to {}
end
