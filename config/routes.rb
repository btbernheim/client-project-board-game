Rails.application.routes.draw do
	root "categories#index"

  resources :sessions
  resources :users

  get '/logout' => 'sessions#destroy'
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'

  resources :categories, only: [:index,:show] do
    resources :games, only: [:index, :show]
  end

  post '/games/:id/upvotes' => 'games#upvote', as: :game_upvote
  post '/games/:id/downvotes' => 'games#downvote', as: :game_downvote
  # Handling comments, follows, votes
  shallow do
    resources :games, only: [] do
      resources :comments
      resources :subscriptions
    end
  end
  post '/comments/:id/upvotes' => 'comments#upvote', as: :comment_upvote
  post '/comments/:id/downvotes' => 'comments#downvote', as: :comment_downvote

  post '/follows/:id' => 'follows#user', as: :follows_user
end
