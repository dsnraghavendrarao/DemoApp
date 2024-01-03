Rails.application.routes.draw do
  resources :employees do
    resources :tax_calcuations, only: [:create, :show, :update]
  end

  

  get "business_year_net_payable" => "employees#business_year_net_payable", defaults: {format: :json}
end

