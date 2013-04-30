S3DirectUpload.config do |c|
  c.access_key_id = ENV['AWS_ACCESS_KEY_ID']       # your access key id
  c.secret_access_key = ENV['AWS_SECRET_ACCESS_KEY']   # your secret access key
  c.bucket = ENV['AWS_BUCKET_NAME']               # your bucket name
#  c.region = ""              # region prefix of your bucket url (optional), eg. "s3-eu-west-1"
#  c.url = ""                 # S3 API endpoint (optional), eg. "https://#{c.bucket}.s3.amazonaws.com/"
end
