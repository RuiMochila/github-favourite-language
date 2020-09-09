Rails.application.routes.draw do
  root to: "pages#home"
  post "/languages", to: "pages#languages"
end
