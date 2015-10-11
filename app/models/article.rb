class Article < ActiveRecord::Base
  before_create :set_slug
  before_update :set_slug
  
  def path
    [nil,
     self.class.to_s.downcase.pluralize,
     self.published_at.year,
     self.published_at.month,
     self.published_at.day,
     self.slug
    ].join("/")
  end

  def public?
    !self.private?
  end
  
  private
  
  def set_slug
    if self.slug.blank?
      self.slug = self.title.gsub(/\'|\"/, "").parameterize
    end
  end
end