Rails.application.routes.draw do
#refactor routes -- paths are too long

  scope '(:locale)' do
    resources :websites do
      resources :blogs, only: [:new, :create, :destroy] do
        resources :posts do
          member do
            get :toggle_status
          end
        end
      end
      resources :pages
      resources :navbars do
        resources :links, only: [:create, :destroy]
      end
    end
    get 'about', to: 'static_pages#about'
    root to: 'static_pages#home'
    get 'static_pages/home'

    get 'static_pages/about'

    devise_for :users

  end
end
