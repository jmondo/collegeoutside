module ApplicationHelper
  KEYS = {
    notice: :success,
    alert:  :error
  }

  def body_class
    "#{controller.controller_name} #{controller.controller_name}-#{controller.action_name}"
  end

  def boostrap_flash_key(key)
    KEYS[key]
  end
end
