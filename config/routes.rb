Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :bhakti_yogas do 
    collection do 
      get :get_more_bhakti_yoga_record_by_ajax
    end
  end
  resources :karam_yogas do 
    collection do 
      get :get_more_karam_yoga_record_by_ajax
    end
  end

  resources :gyan_yogas do 
    collection do 
      get :get_more_gyan_yoga_record_by_ajax
    end
  end 

  resources :kriya_yogas do 
    collection do 
      get :get_more_kriya_yoga_record_by_ajax
    end
  end

  resources :kundalini_yogas do 
    collection do 
      get :get_more_kundalini_yoga_record_by_ajax
    end
  end

  resources :tantra_margs do 
    collection do 
      get :get_more_tantra_marg_record_by_ajax
    end
  end

  resources :aghori_margs do 
    collection do 
      get :get_more_aghori_marg_record_by_ajax
    end
  end

  resources :nad_yogas do 
    collection do 
      get :get_more_nad_yoga_record_by_ajax
    end
  end


  root to: "home#index"
end
