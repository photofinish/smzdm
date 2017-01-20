require 'rest-client'
require 'useragents'

class ApplicationJob < ActiveJob::Base
  queue_as :default

  delegate :job_config, to: :class

  class << self
    def job_config
      @job_config ||= YAML::load(File.read(File.expand_path('config/spider.yml', Rails.root))).with_indifferent_access
    end
  end

  protected
  def default_header
    header = {'User-Agent' => UserAgents.rand() }
    header.update job_config[:header]
  end


  def rest_get(url, header = default_header)
    if url =~ /^(http|https):\/\/(.+?)\//
      header.update 'Host' => $2
    else
      raise "bad url: #{url}"
    end
    res = RestClient.get url, header
    if res.code == 200
      res
    else
      raise res.code
    end
  end
end
