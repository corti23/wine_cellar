class Producer < ApplicationRecord
  has_one :address, :as => :addressable, dependent: :destroy
  accepts_nested_attributes_for :address

  #has_many :bottles
  validates :name, presence: true

  #delegate :url_helpers, to: 'Rails.application.routes'
  #delegate :helpers, to: 'ActionController::Base'

  def bottles_count
    self.projects.count
  end

end
