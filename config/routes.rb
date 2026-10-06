SuperSimpleHELPDESK::Application.routes.draw do

  resources :scores


  resources :assignments
  resources :technicians
  resources :assignations
  resources :categories
  resources :tickets
  resources :users do
	get :autocomplete_user_name, on: :member
	get :autocomplete_user_name, on: :collection
  end
  resources :user_sessions
  resource :users, :as => 'account' 
  root :to => 'reports#index'

  match 'home' => "reports#index",           :as => :home
  match 'login' => "user_sessions#new",      :as => :login
  match 'logout' => "user_sessions#destroy", :as => :logout
  match 'send_students_message' => "user_sessions#send_students_message", :as => :send_students_message
  
  #get 'autocomplete_users' => "account#autocomplete_users" , on: :member # or :member if searching for a specific user

  #match 'generate_report' => "reports#generate_report",           :as => :generate_report
  
  match 'show_personal_tickets' => "tickets#show_personal_tickets", :as => :show_personal_tickets
  match 'show_computer_tickets' => "tickets#show_computer_tickets", :as => :show_computer_tickets
  match 'show_computer_tickets_with_search' => "tickets#show_computer_tickets_with_search", :as => :show_computer_tickets_with_search
  match 'show_communication_tickets_with_search' => "tickets#show_communication_tickets_with_search", :as => :show_communication_tickets_with_search
  match 'show_workshop_tickets_with_search' => "tickets#show_workshop_tickets_with_search", :as => :show_workshop_tickets_with_search
  match 'show_electronic_tickets_with_search' => "tickets#show_electronic_tickets_with_search", :as => :show_electronic_tickets_with_search

  match 'show_computer_tickets_with_advanced_search' => "tickets#show_computer_tickets_with_advanced_search", :as => :show_computer_tickets_with_advanced_search
  match 'show_electronic_tickets_with_advanced_search' => "tickets#show_electronic_tickets_with_advanced_search", :as => :show_electronic_tickets_with_advanced_search
  match 'show_communication_tickets_with_advanced_search' => "tickets#show_communication_tickets_with_advanced_search", :as => :show_communication_tickets_with_advanced_search
  match 'show_maintenance_tickets_with_advanced_search' => "tickets#show_maintenance_tickets_with_advanced_search", :as => :show_maintenance_tickets_with_advanced_search

  match 'show_maintenance_tickets_with_search' => "tickets#show_maintenance_tickets_with_search", :as => :show_maintenance_tickets_with_search
  
  match 'show_electronic_tickets' => "tickets#show_electronic_tickets", :as => :show_electronic_tickets
  match 'show_workshop_tickets' => "tickets#show_workshop_tickets", :as => :show_workshop_tickets
  match 'show_communication_tickets' => "tickets#show_communication_tickets", :as => :show_communication_tickets
  match 'show_maintenance_tickets' => "tickets#show_maintenance_tickets", :as => :show_maintenance_tickets
  match 'show_inprocess_tickets' => "tickets#show_inprocess_tickets", :as => :show_inprocess_tickets
  match 'show_unattended_tickets' => "tickets#show_unattended_tickets", :as => :show_unattended_tickets
  match 'show_attended_tickets' => "tickets#show_attended_tickets", :as => :show_attended_tickets
  match 'show_froze_tickets' => "tickets#show_froze_tickets", :as => :show_froze_tickets
  match 'show_inrevision_tickets' => "tickets#show_inrevision_tickets", :as => :show_inrevision_tickets
  match 'show_canceled_tickets' => "tickets#show_canceled_tickets", :as => :show_canceled_tickets
  match 'show_canceled_tickets_with_search' => "tickets#show_canceled_tickets_with_search", :as => :show_canceled_tickets_with_search

  get 'reports/:department' => 'reports#department_reports', :as => :department_reports

  get 'tickets/take_ticket/:id' => 'tickets#take_ticket', :via => :get
  get 'tickets/close_ticket/:id' => 'tickets#close_ticket', :via => :get
  get 'reports/approve_ticket/:id' => 'reports#approve_ticket', :via => :get
  get 'reports/not_approve_ticket/:id' => 'reports#not_approve_ticket', :via => :get
 
  namespace :api do
    namespace :v1 do
      resources :tickets, only: [:index, :create, :show] 
    end
  end

 end
