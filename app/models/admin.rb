class Admin < User
  def devise_scope
    :admin
  end
end
