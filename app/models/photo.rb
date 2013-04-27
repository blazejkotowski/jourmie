class Photo < ContentPiece
  mount_uploader :file, PhotoUploader
end
