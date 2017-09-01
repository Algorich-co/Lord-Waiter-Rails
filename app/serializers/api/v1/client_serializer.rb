class Api::V1::ClientSerializer < Api::V1::BaseSerializer
  
  attributes :id, :email, :name, :created_at, :updated_at
 
end