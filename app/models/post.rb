class Post < ActiveRecord::Base

	mount_uploader :picture, PictureUploaderUploader

end
