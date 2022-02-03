SuperSimpleHELPDESK::Application.routes.draw do

  resources :assignments
  resources :technicians
  resources :assignations
  resources :categories
  resources :tickets
  resources :users
  resources :user_sessions
  resource :users, :as => 'account' 

  root :to => 'reports#index'

  match 'home' => "reports#index",           :as => :home
  match 'login' => "user_sessions#new",      :as => :login
  match 'logout' => "user_sessions#destroy", :as => :logout
  match 'send_students_message' => "user_sessions#send_students_message", :as => :send_students_message

  match 'my_workshop_reports' => "reports#my_workshop_reports",           :as => :my_workshop_reports
  match 'my_electronic_reports' => "reports#my_electronic_reports",           :as => :my_electronic_reports
  match 'my_computer_reports' => "reports#my_computer_reports",           :as => :my_computer_reports
  match 'my_communication_reports' => "reports#my_communication_reports",           :as => :my_communication_reports
  match 'my_maintenance_reports' => "reports#my_maintenance_reports",           :as => :my_maintenance_reports
  match 'generate_report' => "reports#generate_report",           :as => :generate_report

  match 'show_computer_tickets' => "tickets#show_computer_tickets", :as => :show_computer_tickets
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

  get 'tickets/take_ticket/:id' => 'tickets#take_ticket', :via => :get
  get 'tickets/close_ticket/:id' => 'tickets#close_ticket', :via => :get
  get 'reports/approve_ticket/:id' => 'reports#approve_ticket', :via => :get
  get 'reports/not_approve_ticket/:id' => 'reports#not_approve_ticket', :via => :get

 end
