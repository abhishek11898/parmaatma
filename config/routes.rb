Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :bhakti_yogas
  resources :karam_yogas
  resources :gyan_yogas
  resources :kriya_yogas
  resources :kundalini_yogas
  resources :tantra_margs
  resources :aghori_margs
  resources :nad_yogas

  root to: "home#index"
end
