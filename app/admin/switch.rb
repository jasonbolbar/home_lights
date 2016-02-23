ActiveAdmin.register Switch do

  permit_params :name, :pin_number, :switch_type, :status

  before_filter :skip_sidebar!, only: :index

  form do |f|
    inputs 'Add Switch' do
      f.input :name
      f.input :pin_number, as: :select, collection: Switch.available_switches, include_blank: false
      f.input :switch_type, as: :select, collection: Switch::SWITCH_TYPES, include_blank: false
    end
    f.actions
  end

  show do
    attributes_table do
      row :name
      row :pin_number
      row :status do |switch|
        switch_status switch
      end
    end
  end

  index do
    column :name do |switch|
      link_to(switch.name, admin_switch_path(switch))
    end
    column :pin_number
    column :status, sortable: false do |switch|
      switch_status switch
    end
    column do |switch|
      bootstrap_switch(switch)
    end
    actions
  end

  member_action :activate_switch, method: :post do
    if eval(params[:status])
      resource.turn_on
    else
      resource.turn_off
    end
    render json: {icon: ActionController::Base.helpers.asset_path(resource.status ? 'lightbulb-on.png' : 'lightbulb-off.png')}
  end

  member_action :activate_button, method: :post do
    resource.press_button
  end

end
