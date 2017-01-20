class HtmlGetJob < ApplicationJob
  def perform(*args)
    url = args.pop
    logger.info "http get: #{url}"
    res = rest_get url
    web_html = WebHtml.create! url: url, html_date: res.headers[:date], html_code: res.body
    Rabbit.publish 'model.web_html.create'.freeze, id: web_html.id
  end

end