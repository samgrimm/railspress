Rails.application.routes.draw do
  scope '(:locale)' do
    resources :websites do
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
