# config/routes.rb
Rails.application.routes.draw do
  # トップページ
  root "home#index"
  # ユーザー登録
  resources :users, only: [ :new, :create ]
  # ログイン/ログアウト
  get    "/login",  to: "sessions#new"
  post   "/login",  to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  # 部屋関連
  resources :rooms, only: [ :new, :create, :index, :show ] do
  resources :reservations, only: [ :index, :create, :destroy ] do
    collection do
      match :confirm, via: [ :get, :post ]
    end
  end
  end

  # ユーザー全体の予約一覧
  get "/my_reservations", to: "reservations#my_index", as: "my_reservations"

  # PWA関連（現在は未対応のためコメントアウト）
  # get "up" => "rails/health#show", as: :rails_health_check
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # ホーム
  get "home/index"
end
