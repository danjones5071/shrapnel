Rails.application.routes.draw do
  root 'site#index'

  namespace :api do
    namespace :v1 do
      resources :issues, only: %i[index show create destroy]
    end
  end
end
