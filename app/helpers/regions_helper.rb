module RegionsHelper
  def region_link(region_name)
    active = (params[:region_name_eq] == region_name)
    new_params = params.merge({region_name_eq: region_name})
    link_to '', new_params, class: "region region-#{region_name}#{' region-active' if active}"
  end
end
