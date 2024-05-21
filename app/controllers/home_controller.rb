class HomeController < ApplicationController
  def index
    @bhakti_yogas = BhaktiYoga.limit(3)
    @karam_yogas = KaramYoga.limit(3)
    @gyan_yogas = GyanYoga.limit(3)
    @kriya_yogas = KriyaYoga.limit(3)
  end
end