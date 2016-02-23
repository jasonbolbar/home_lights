module SwitchesHelper

  def switch_status(switch)
    if switch.is_a_button?
      content_tag(:p, 'Not available')
    else
      image_tag(switch.status ? 'lightbulb-on.png' : 'lightbulb-off.png', width: '22', id: "status-#{switch.id}")
    end
  end

  def bootstrap_switch(switch, path=nil)
    if switch.is_a_button?
      link_to(switch.name, activate_button_admin_switch_path(switch), class: 'btn btn-primary')
    else
      check_box_tag("switch-#{switch.id}", path || activate_switch_admin_switch_path(switch), switch.status,
                    class: 'bootstrap-switch-input',status_icon:"status-#{switch.id}")
    end
  end

end