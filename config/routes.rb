Rails.application.routes.draw do

#refactor routes -- paths are too long

  scope '(:locale)' do
    resources :websites do
      resources :blogs, only: [:new, :create, :destroy] do
        resources :posts do
          resources :widgets
          member do
            get :toggle_status
          end
        end
      end
      resources :pages do
        resources :widgets, only: [:sort, :create] do
          put :sort, on: :collection, as: '/sort'
        end
      end
      resources :navbars do
        resources :links, only: [:create, :destroy]
      end
    end
    get 'about', to: 'static_pages#about'
    root to: 'static_pages#home'
    get 'static_pages/home'

    get 'static_pages/about'

    devise_for :users


    mount ActionCable.server => '/cable'

  end
end
