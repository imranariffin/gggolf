CarrierWave.configure do |config|
  config.root = Rails.root.join('public')
  config.fog_credentials = {
    :provider               => 'AWS',                        # required
    :aws_access_key_id      => 'AKIAJKVABLGDGLRGN2WA',                        # required
    :aws_secret_access_key  => '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'                         # required
  }
  config.fog_directory  = 'csc444'                     # required
  config.fog_public     = true
  
end