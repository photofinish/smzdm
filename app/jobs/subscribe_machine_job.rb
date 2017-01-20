class SubscribeMachineJob < ActiveJob::Base

  def self.active?
    @active ||= false
  end
  def self.active!
    @active = true
  end

  def perform(*args)
    logger.info "SubscribeMachine job perform..."
    if !SubscribeMachineJob.active?
      logger.info "SubscribeMachine init!"
      Rabbit.subscribe 'model.web_html.create'.freeze, :web_html_create do |json|
        puts "found a web html created: #{json}"
        HtmlParseJob.perform_later json['id']
      end

      SubscribeMachineJob.active!
    end

  end

end