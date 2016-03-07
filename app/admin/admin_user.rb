ActiveAdmin.register AdminUser do

  permit_params :email, :password, :password_confirmation
  before_filter :skip_sidebar!, only: :index

  index do
    column :email do |user|
      link_to(user.email, admin_admin_user_path(user))
    end
    column :last_sign_in_ip
    column :current_sign_in_ip
    column :failed_attempts
    column :sign_in_count
    actions
  end

  show do
    attributes_table do
      row :email
      row :last_sign_in_ip
      row :current_sign_in_ip
      row :failed_attempts
      row :sign_in_count
    end
  end

  form do |f|
    inputs do
      f.semantic_errors *f.object.errors.keys
      f.input :email
    end
    f.actions
  end

  controller do

    before_create do |admin_user|
      password = Devise.friendly_token.first(8)
      admin_user.password = password
      admin_user.password_confirmation = password
    end

  end

end
