Soundwave::Application.routes.draw do
  resources :sounds, :except => [:edit, :update, :destroy]
end
