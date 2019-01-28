class AppointmentSession < ApplicationRecord

  belongs_to :appointment, optional: true

end
