class TicketSerializer < ActiveModel::Serializer
  attributes :id, :category, :description, :status, :user_id, :department, :email, :folio, :created_at, :updated_at
  has_one :user
end
