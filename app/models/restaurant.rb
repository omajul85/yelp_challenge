class Restaurant < ActiveRecord::Base
	
  belongs_to :user
  has_many :reviews,
      -> { extending WithUserAssociationExtension }, dependent: :destroy
	validates :name, length: { minimum: 3 }, uniqueness: true

  # has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  # validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  # attr_accessible :picture
  mount_uploader :picture, PictureUploader

	def average_rating
		return 'N/A' if reviews.none?
		reviews.average(:rating)
		# reviews.sum(:rating) / reviews.count
	end

  def created_by?(current_user)
    user == current_user
  end

end
