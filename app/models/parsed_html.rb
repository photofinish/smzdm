class ParsedHtml < WebHtml
  belongs_to :web_html
  field :parsed_html, type: String
end