class Post < ActiveRecord::Base

	mount_uploader :picture, PictureUploaderUploader
	crop_uploaded :picture

	belongs_to :user

	validates_presence_of :link
	validates_presence_of :picture
	validates_presence_of :title
	validates_presence_of :description

end
