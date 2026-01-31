# config/routes.rb
Rails.application.routes.draw do
  # トップページ
  root "home#index"

  # ユーザー登録
  resources :users, only: [ :new, :create, :edit, :update ]

  # アカウント
  get  "/account",      to: "users#account",      as: :account
  get  "/account/edit", to: "users#edit_account", as: :edit_account
  patch "/account",     to: "users#update_account"

  # プロフィール
  get  "/profile",      to: "users#profile",      as: :profile
  get  "/profile/edit", to: "users#edit_profile", as: :edit_profile
  patch "/profile",     to: "users#update_profile"

  # ログイン/ログアウト
  get    "/login",  to: "sessions#new"
  post   "/login",  to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  # マイページ
  get "/my_page", to: "users#my_page", as: "my_page"

  # 予約済み一覧用
  get "/my_reservations", to: "reservations#my_index", as: "my_reservations"

  # 部屋関連
  resources :rooms, only: [ :new, :create, :index, :show, :edit, :update, :destroy ] do
    resources :reservations, only: [ :index, :create, :new, :edit, :update, :destroy ] do
      collection do
        match :confirm, via: [ :get, :post ]
      end
    end
  end

  # 自分の登録した部屋一覧ページ
  get "my_rooms", to: "rooms#my_index"

  # PWA関連（現在は未対応のためコメントアウト）
  # get "up" => "rails/health#show", as: :rails_health_check
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # ホーム
  get "home/index"
end
