Rails.application.routes.draw do


  # set the normal resources path
  resources :apps

  # in the scope of the app show the csr options
  scope "apps/:id" do
    match "csr" => "csr#new", :as => :csr_app
  end

  # define the root
  root :to => "apps#index"

end
