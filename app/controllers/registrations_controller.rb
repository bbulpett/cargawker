# This controller defines a class which inherits from Devise's Registrations Controller
class RegistrationsController < Devise::RegistrationsController
  # Route new users to their respective page after registration
  def after_sign_up_path_for(resource)
    new_user_customers_path(current_user)
  end

end