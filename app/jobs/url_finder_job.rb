class UrlFinderJob < ApplicationJob

  def perform(*args)
    url = 'http://www.smzdm.com/jingxuan/'
    HtmlGetJob.perform_later url
  end

end