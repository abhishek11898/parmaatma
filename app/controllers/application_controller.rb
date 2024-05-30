class ApplicationController < ActionController::Base
  layout :set_layout
  before_action :set_enlightened_beings

  private
  def set_layout
    if devise_controller?
      'before_login'
    else
      'application'
    end
  end

  def set_enlightened_beings
    @enlightened_beings = EnlightenedBeing.all
  end
end
