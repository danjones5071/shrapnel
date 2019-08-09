Rails.application.routes.draw do
  root 'site#index'

  namespace :api do
    namespace :v1 do
      resources :issues, only: %i[index show create update destroy]
    end
  end
end
