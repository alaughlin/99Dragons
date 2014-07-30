Nine9Dragons::Application.routes.draw do
  resources :dragons
  resources :rentals do
    member do
      patch 'approve'
    end

    member do
      patch 'deny'
    end
  end
end
