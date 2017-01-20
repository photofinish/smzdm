class SmzdmFeed
  include Mongoid::Document
  default_scope ->{ order(post_at: :desc) }
  field :title, type: String
  field :price, type: String
  field :url, type: String
  field :image, type: String
  field :tag, type: String
  field :digest, type: String
  field :description, type: String
  field :deserved, type: String
  field :undeserved, type: String
  field :post_at, type: DateTime
  field :store, type: String
end