class WebHtml
  include Mongoid::Document
  has_one :parsed_html
  field :url, type: String
  field :html_date, type: DateTime
  field :html_code, type: String
  field :type, type: String
end
