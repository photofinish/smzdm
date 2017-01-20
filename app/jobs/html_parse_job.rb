class HtmlParseJob < ApplicationJob

  def perform(*args)
    puts "---"*23
    id = args.pop
    puts id
    web_html = WebHtml.find id
    puts web_html
    doc = Nokogiri::HTML web_html.html_code
    doc.css('#feed-main #feed-main-list li').each do |html|
      url = html.xpath('h5/a').first[:href]
      next if SmzdmFeed.find_by url: url
      title = html.xpath('h5/a/text()').first
      price = html.xpath('h5/a/span/text()').first
      image = html.xpath('div/div/a/img').first[:src]
      tag = html.xpath('div/div/div/span/a').text.strip
      digest = html.xpath('div/div/div/strong/text()').text.strip
      description = html.xpath('div/div/div/text()').text.strip
      deserved = html.xpath('div/div/div/div/span/a/span/span/text()')[0]
      undeserved = html.xpath('div/div/div/div/span/a/span/span/text()')[1]
      post_at = html.xpath('div/div/div/div/span/text()').text.strip
      store = html.xpath('div/div/div/div/span/a/text()').text.strip
      begin
        parsed_time = ActiveSupport::TimeZone["Beijing"].strptime(post_at, '%m-%d %H:%M').localtime
      rescue ArgumentError
        parsed_time = ActiveSupport::TimeZone["Beijing"].strptime(post_at, '%H:%M').localtime
      ensure
        post_at = parsed_time if parsed_time.present?
      end
      SmzdmFeed.create! title: title, price: price, url:url, image:image, tag: tag, digest: digest,
                        description: description, deserved: deserved, undeserved: undeserved, post_at:post_at, store: store
    end
  end
end