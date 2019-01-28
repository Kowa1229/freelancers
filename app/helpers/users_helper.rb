module UsersHelper

  def is_employer?
    current_user.employer == true ? true : false
  end

end
