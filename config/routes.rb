Rails.application.routes.draw do
  devise_for :admins
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :bhakti_yogas do 
    collection do 
      get :get_more_bhakti_yogas_record_by_ajax
    end
  end
  resources :karam_yogas do 
    collection do 
      get :get_more_karam_yogas_record_by_ajax
    end
  end

  resources :gyan_yogas do 
    collection do 
      get :get_more_gyan_yogas_record_by_ajax
    end
  end 

  resources :kriya_yogas do 
    collection do 
      get :get_more_kriya_yogas_record_by_ajax
    end
  end

  resources :kundalini_yogas do 
    collection do 
      get :get_more_kundalini_yogas_record_by_ajax
    end
  end

  resources :tantra_margs do 
    collection do 
      get :get_more_tantra_margs_record_by_ajax
    end
  end

  resources :aghori_margs do 
    collection do 
      get :get_more_aghori_margs_record_by_ajax
    end
  end

  resources :nad_yogas do 
    collection do 
      get :get_more_nad_yogas_record_by_ajax
    end
  end

  resources :enlightened_beings do 
    collection do 
      get :get_more_enlightened_beings_record_by_ajax
    end
  end

  root to: "home#index"
end
