class User < ActiveRecord::Base
  has_secure_password
  has_attached_file :profile_image, 
    :path => ":rails_root/public/system/:class/:attachement/:id/:basename_:style.:extension",
    :url => "/system/:class/:attachement/:id/:basename_:style.:extension",
    :styles => {
      :thumb    => ['100x100#',  :jpg, :quality => 70],
      :preview  => ['480x480#',  :jpg, :quality => 70],
      :large    => ['600>',      :jpg, :quality => 70],
      :retina   => ['1200>',     :jpg, :quality => 30]
    },
    :convert_options => {
      :thumb    => '-set colorspace sRGB -strip',
      :preview  => '-set colorspace sRGB -strip',
      :large    => '-set colorspace sRGB -strip',
      :retina   => '-set colorspace sRGB -strip -sharpen 0x0.5'
    }

  validates_attachment :profile_image,
    :presence => true,
    :size => { :in => 0..10.megabytes },
    :content_type => { :content_type => /^image\/(jpeg|png|gif|tiff)$/ }

  validates :username,
    :presence => true,
    :uniqueness => true

  validates :email,
    :presence => true,
    :uniqueness => true

  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i

  validates :first_name,
    :presence => true

  validates :last_name,
    :presence => true

  validates :password,
    :length => { :minimum => 8 }

end
