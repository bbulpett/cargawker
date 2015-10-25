class Post < ActiveRecord::Base

	mount_uploader :picture, PictureUploaderUploader
	crop_uploaded :picture

	belongs_to :user

end
