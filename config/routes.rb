Blog::Application.routes.draw do
  root 'layouts#application'

  scope :api do
    devise_for :users, controllers: {
      sessions:      'sessions',
      registrations: 'registrations'
    }

    resources :posts, defaults: {format: :json}
  end

  match '*path' => 'layouts#application', via: [:get, :post]
end
