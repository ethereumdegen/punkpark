class Punk < ActiveRecord::Base

  mount_uploader :avatar, PunkAvatarUploader

end
