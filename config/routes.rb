Rails.application.routes.draw do
  root "shorturls#render_form"
   resource :shorturls do
     post 'create_short_url' => 'shorturls#short_url_generate'
     get '/analytics' => 'shorturls#analytics'
   end
   get '/:shortened_url' => 'shorturls#show_short_url'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
