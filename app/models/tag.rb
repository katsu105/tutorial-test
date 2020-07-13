class Tag < ApplicationRecord
  has_many :post_tags
  has_many :posts, through: :post_tags
  validates :tag, presence: true

  def self.multiple_tag_save(tags, post)
    tags.each do |tag|
      post.tags.create(tag: tag)
    end
  end
end
