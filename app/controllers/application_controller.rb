class ApplicationController < ActionController::Base

  layout 'application'
  before_action :set_enlightened_beings

  private
  def set_enlightened_beings
    @enlightened_beings = EnlightenedBeing.all
  end
end
