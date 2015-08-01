class Ckeditor::Picture < Ckeditor::Asset
  has_attached_file :data, 
                    :styles => { :content => '800>', :thumb => '118x100#'},
                    :storage  => :s3,
                    :s3_credentials => {
                      :bucket => ENV['S3_BUCKET'],
                      :access_key_id => ENV['S3_KEY'],
                      :secret_access_key => ENV['S3_SECRET']
                    },
                    :path => ":rails_root/public/#{config.upload_path}/pictures/:id/:style_:basename.:extension",
                    :url => ":s3_domain_url"

  validates_attachment :data,
                       :presence => true,
                       :content_type => {:content_type => /\Aimage\/.*\Z/},
                       :size => {:less_than => config.max_picture_size}

  def url_content
    url(:content)
  end
end
