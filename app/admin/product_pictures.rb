ActiveAdmin.register ProductPicture do
  belongs_to :product

  form :partial => "form"

  index do
    column :main do |resource|
      radio_button_tag(:main, resource.id, resource.main?)
    end

    column :product

    column :picture do |resource|
      image_tag(resource.picture_url(:small))
    end

    column :created_at

    column :updated_at

    default_actions
  end

  show do |resource|
    attributes_table do
      row :product

      row :picture do
        image_tag(resource.picture_url(:middle))
      end

      row :main
      row :created_at
      row :updated_at
    end

    active_admin_comments
  end

  member_action :mark_as_main, :method => :put do
    picture = ProductPicture.find(params[:id])
    picture.mark_as_main!

    render :text => "Picture marked as 'main'"
  end
end
