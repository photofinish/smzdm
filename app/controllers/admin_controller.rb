class AdminController < ApplicationController
  def index
    @feeds = SmzdmFeed.all
    SubscribeMachineJob.perform_now
  end
end
