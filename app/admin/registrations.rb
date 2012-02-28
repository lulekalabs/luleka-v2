ActiveAdmin.register Registration do

  index do
    column :email
    column :name
    column :locale
    column :ip_address
    column :created_at
    # default_actions
    column do |resource|
      links = link_to I18n.t('active_admin.view'), resource_path(resource), :class => "member_link view_link"
      links += link_to I18n.t('active_admin.edit'), edit_resource_path(resource), :class => "member_link edit_link"
      links += link_to I18n.t('active_admin.delete'), resource_path(resource), 
        :method => :delete, :class => "member_link delete_link", :confirm => "Are you really really really sure?"
      links
    end
  end

end
