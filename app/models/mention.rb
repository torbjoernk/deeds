class Mention < ActiveRecord::Base
  belongs_to :person
  belongs_to :role
  belongs_to :place
end
